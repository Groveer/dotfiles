import QtQuick
import QtMultimedia
import Quickshell
import Quickshell.Wayland
import qs.Commons
import qs.Widgets
import qs.Services.UI

Item {
    id: root

    property var pluginApi: null

    property bool isVisible: false
    function show()   { isVisible = true  }
    function hide()   { isVisible = false }
    function toggle() { isVisible = !isVisible }

    property bool isSquare:   true
    property bool isFlipped:  true
    property int  currentWidth:  300
    property int  currentHeight: 300
    property int  xPos: -1
    property int  yPos: -1

    // Track which screen was active when the mirror was first shown.
    // This is more reliable than always using Quickshell.screens[0],
    // which is not guaranteed to be the user's main monitor.
    property var _primaryScreen: null

    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            id: win
            required property ShellScreen modelData

            // isPrimary is true for whichever screen was current when mirror
            // was first opened, or the first screen as a safe fallback.
            readonly property bool isPrimary: modelData === (root._primaryScreen ?? Quickshell.screens[0])

            screen: modelData
            anchors { top: true; bottom: true; left: true; right: true }
            color: "transparent"
            visible: root.isVisible
            exclusionMode: ExclusionMode.Ignore

            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
            WlrLayershell.namespace: "noctalia-mirror"

            onVisibleChanged: {
                if (visible && isPrimary) {
                    if (root.xPos === -1 && screen.width > 0) {
                        // First show: place in the top-right corner
                        root.xPos = screen.width  - root.currentWidth  - 24
                        root.yPos = Math.round((screen.height - root.currentHeight) / 2)
                    } else {
                        // Subsequent shows: clamp position in case resolution changed
                        root.xPos = Math.max(0, Math.min(root.xPos, screen.width  - root.currentWidth))
                        root.yPos = Math.max(0, Math.min(root.yPos, screen.height - root.currentHeight))
                    }
                }
            }

            readonly property bool isInteracting:
                isPrimary && (dragArea.pressed || resizeBR.pressed || resizeBL.pressed ||
                              resizeTR.pressed || resizeTL.pressed)

            Item { id: fullMask; anchors.fill: parent }

            // Non-primary windows are fully click-through (mask: null).
            // Primary uses fullMask during interaction so resize/drag don't
            // lose events, and container mask otherwise to stay minimal.
            mask: Region { item: !win.isPrimary ? null : (win.isInteracting ? fullMask : container) }

            MediaDevices { id: mediaDevices }

            Rectangle {
                id: container
                visible: win.isPrimary
                x: root.xPos
                y: root.yPos
                width:  root.currentWidth
                height: root.currentHeight
                radius: Style.radiusL
                color: "black"
                clip: true

                Loader {
                    id: cameraLoader
                    active: win.visible && win.isPrimary
                    anchors.fill: parent
                    sourceComponent: Component {
                        Item {
                            anchors.fill: parent
                            CaptureSession {
                                camera: Camera {
                                    id: camera
                                    active: true
                                    cameraDevice: mediaDevices.videoInputs[0] ?? mediaDevices.defaultVideoInput
                                }
                                videoOutput: videoOutput
                            }
                            VideoOutput {
                                id: videoOutput
                                anchors.fill: parent
                                fillMode: VideoOutput.PreserveAspectCrop
                                transform: Scale {
                                    origin.x: videoOutput.width / 2
                                    xScale: root.isFlipped ? -1 : 1
                                }
                            }
                        }
                    }
                }

                // ── No camera fallback ──────────────────
                Column {
                    anchors.centerIn: parent
                    spacing: Style.marginS
                    visible: mediaDevices.videoInputs.length === 0
                    NIcon { anchors.horizontalCenter: parent.horizontalCenter; icon: "video-off"; color: Color.mOnSurfaceVariant }
                    NText { anchors.horizontalCenter: parent.horizontalCenter; text: "No camera found"; color: Color.mOnSurfaceVariant; pointSize: Style.fontSizeXS }
                }

                HoverHandler { id: containerHover }

                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor

                    property point startPoint: Qt.point(0, 0)
                    property int startX: 0; property int startY: 0

                    onPressed: mouse => {
                        startPoint = mapToItem(null, mouse.x, mouse.y)
                        startX = root.xPos; startY = root.yPos
                    }
                    onPositionChanged: mouse => {
                        if (!pressed) return
                        var p = mapToItem(null, mouse.x, mouse.y)
                        root.xPos = Math.max(0, Math.min(win.screen.width  - root.currentWidth,  startX + (p.x - startPoint.x)))
                        root.yPos = Math.max(0, Math.min(win.screen.height - root.currentHeight, startY + (p.y - startPoint.y)))
                    }
                }

                // ── Controls ────────────────────────────
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: Style.marginM
                    width: ctrlRow.implicitWidth + Style.marginM * 2
                    height: 44
                    radius: 22
                    color: Qt.rgba(0, 0, 0, 0.55)
                    z: 3
                    opacity: containerHover.hovered ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 150 } }

                    Row {
                        id: ctrlRow
                        anchors.centerIn: parent
                        spacing: Style.marginS

                        // Square/Wide toggle
                        Rectangle {
                            width: 32; height: 32; radius: 16
                            color: sqHover.containsMouse ? Qt.rgba(1,1,1,0.2) : "transparent"
                            NIcon { anchors.centerIn: parent; icon: root.isSquare ? "arrows-maximize" : "crop"; color: "white" }
                            MouseArea {
                                id: sqHover
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor; hoverEnabled: true
                                onClicked: {
                                    root.isSquare = !root.isSquare
                                    root.currentHeight = root.isSquare
                                        ? root.currentWidth
                                        : Math.round(root.currentWidth * 9 / 16)
                                    root.xPos = Math.max(0, Math.min(win.screen.width  - root.currentWidth,  root.xPos))
                                    root.yPos = Math.max(0, Math.min(win.screen.height - root.currentHeight, root.yPos))
                                }
                                onEntered: TooltipService.show(parent, root.isSquare ? root.pluginApi?.tr("tooltips.switchToWide") : root.pluginApi?.tr("tooltips.switchToSquare"))
                                onExited:  TooltipService.hide()
                            }
                        }

                        // Flip toggle
                        Rectangle {
                            width: 32; height: 32; radius: 16
                            color: root.isFlipped ? Qt.rgba(1,1,1,0.25) : (flipHover.containsMouse ? Qt.rgba(1,1,1,0.15) : "transparent")
                            NIcon { anchors.centerIn: parent; icon: "flip-horizontal"; color: "white" }
                            MouseArea {
                                id: flipHover
                                anchors.fill: parent; cursorShape: Qt.PointingHandCursor; hoverEnabled: true
                                onClicked: root.isFlipped = !root.isFlipped
                                onEntered: TooltipService.show(parent, root.isFlipped ? root.pluginApi?.tr("tooltips.unflipCamera") : root.pluginApi?.tr("tooltips.flipCamera"))
                                onExited:  TooltipService.hide()
                            }
                        }

                        // Close
                        Rectangle {
                            width: 32; height: 32; radius: 16
                            color: closeHover.containsMouse ? Qt.rgba(1,1,1,0.2) : "transparent"
                            NIcon { anchors.centerIn: parent; icon: "x"; color: "white" }
                            MouseArea {
                                id: closeHover; anchors.fill: parent
                                hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                onClicked: root.hide()
                                onEntered: TooltipService.show(parent, root.pluginApi?.tr("pin.close"))
                                onExited:  TooltipService.hide()
                            }
                        }
                    }
                }

                // ── Resize handles ──────────────────────
                component ResizeHandle: MouseArea {
                    property int mode: 0
                    width: 20; height: 20
                    hoverEnabled: true
                    preventStealing: true
                    cursorShape: (mode === 0 || mode === 3) ? Qt.SizeFDiagCursor : Qt.SizeBDiagCursor
                    z: 4

                    property point startPt: Qt.point(0, 0)
                    property int startW: 0; property int startH: 0
                    property int startX: 0; property int startY: 0

                    onPressed: mouse => {
                        startPt = mapToItem(null, mouse.x, mouse.y)
                        startW = root.currentWidth;  startH = root.currentHeight
                        startX = root.xPos;          startY = root.yPos
                        mouse.accepted = true
                    }
                    onPositionChanged: mouse => {
                        if (!pressed) return
                        var p  = mapToItem(null, mouse.x, mouse.y)
                        var dx = p.x - startPt.x
                        var dy = p.y - startPt.y
                        var nw = startW
                        var nx = startX; var ny = startY

                        if      (mode === 0) { nw = Math.max(150, startW + dx) }
                        else if (mode === 1) { nw = Math.max(150, startW - dx); nx = startX + (startW - nw) }
                        else if (mode === 2) { nw = Math.max(150, startW + dx) }
                        else if (mode === 3) { nw = Math.max(150, startW - dx); nx = startX + (startW - nw) }

                        var nh = root.isSquare ? nw : Math.round(nw * 9 / 16)
                        nh = Math.max(100, nh)

                        if (mode === 2 || mode === 3) ny = startY + (startH - nh)

                        root.currentWidth  = nw
                        root.currentHeight = nh
                        root.xPos = Math.max(0, nx)
                        root.yPos = Math.max(0, ny)
                    }

                    Rectangle {
                        anchors.centerIn: parent; width: 8; height: 8; radius: 4
                        color: Color.mPrimary
                        opacity: parent.containsMouse || parent.pressed ? 1.0 : 0.4
                        Behavior on opacity { NumberAnimation { duration: 120 } }
                    }
                }

                ResizeHandle { id: resizeBR; mode: 0; anchors.bottom: parent.bottom; anchors.right: parent.right }
                ResizeHandle { id: resizeBL; mode: 1; anchors.bottom: parent.bottom; anchors.left:  parent.left  }
                ResizeHandle { id: resizeTR; mode: 2; anchors.top:    parent.top;    anchors.right: parent.right }
                ResizeHandle { id: resizeTL; mode: 3; anchors.top:    parent.top;    anchors.left:  parent.left  }
            }
        }
    }

    // Store the current screen when mirror is first toggled on.
    // pluginApi.withCurrentScreen gives us the screen where the panel
    // lives, which is the right monitor to show the mirror on.
    onIsVisibleChanged: {
        if (isVisible && _primaryScreen === null && pluginApi) {
            pluginApi.withCurrentScreen(screen => { _primaryScreen = screen })
        } else if (!isVisible) {
            _primaryScreen = null
        }
    }
}
