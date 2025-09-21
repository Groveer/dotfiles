"use strict";
(function (mp) {
  var userOptions = {
    dir: mp.get_property("working-directory"),
    frameSize: "iw*0.7:ih*0.7",
    fps: 45,
    loop: 0,
    audio: false,
  };
  var envOptions = {
    startTime: -1,
    endTime: -1,
    filename: "",
    basename: "",
    currentSubFilter: "",
    tracksList: [],
    audioCodec: "",
  };
  var animatePicType;
  (function (animatePicType) {
    animatePicType["webp"] = ".webp";
    animatePicType["gif"] = ".gif";
    animatePicType["png"] = ".png";
  })(animatePicType || (animatePicType = {}));
  function validateTime() {
    if (
      envOptions.startTime === -1 ||
      envOptions.endTime === -1 ||
      envOptions.startTime >= envOptions.endTime
    ) {
      mp.osd_message("Invalid start/end time. ");
      return false;
    }
    return true;
  }
  function initEnvOptions() {
    envOptions.filename = mp.get_property("filename") || "";
    envOptions.basename = mp.get_property("filename/no-ext") || "";
    envOptions.tracksList = JSON.parse(mp.get_property("track-list") || "");
    dump("userOption:", userOptions);
    dump("envOptions", envOptions);
  }
  function setStartTime() {
    envOptions.startTime = mp.get_property_number("time-pos", -1);
    mp.osd_message("GIF Start: ".concat(envOptions.startTime));
  }
  function setEndTime() {
    envOptions.endTime = mp.get_property_number("time-pos", -1);
    mp.osd_message("GIF End: ".concat(envOptions.endTime));
  }
  function pathCorrect(path) {
    return path.replace(/\\/g, "/");
  }
  function getCurrentSub() {
    for (var index in envOptions.tracksList) {
      var currentObj = envOptions.tracksList[index];
      if (currentObj["selected"] && currentObj["type"] === "sub") {
        if (currentObj["external"] === true) {
          envOptions.currentSubFilter = "subtitles='".concat(
            pathCorrect(currentObj["external-filename"]),
            "':si=0"
          );
        } else {
          envOptions.currentSubFilter = "subtitles='".concat(
            envOptions.filename,
            "'"
          );
        }
      }
    }
  }
  function getAudioType() {
    for (var index in envOptions.tracksList) {
      var currentObj = envOptions.tracksList[index];
      if (
        currentObj["selected"] &&
        currentObj["type"] === "audio" &&
        currentObj["external"] !== true
      ) {
        envOptions.audioCodec = currentObj["codec"];
        return currentObj["codec"];
      }
    }
    return "";
  }
  function geneRateAnimatedPic(picType, hasSubtitles) {
    if (!validateTime()) {
      return;
    }
    mp.osd_message("Creating GIF.");
    getCurrentSub();
    var commands = [];
    if (envOptions.currentSubFilter && hasSubtitles) {
      commands = [
        "ffmpeg",
        "-v",
        "warning",
        "-ss",
        "".concat(envOptions.startTime),
        "-copyts",
        "-i",
        "".concat(envOptions.filename),
        "-to",
        "".concat(envOptions.endTime),
        "-loop",
        "".concat(userOptions.loop),
        "-vf",
        "fps="
          .concat(userOptions.fps, ",scale=")
          .concat(userOptions.frameSize, ",")
          .concat(envOptions.currentSubFilter),
        "-ss",
        "".concat(envOptions.startTime),
        ""
          .concat(envOptions.basename, "[")
          .concat(envOptions.startTime.toFixed(), "-")
          .concat(envOptions.endTime.toFixed(), "]")
          .concat(picType),
      ];
    } else {
      commands = [
        "ffmpeg",
        "-v",
        "warning",
        "-i",
        "".concat(envOptions.filename),
        "-ss",
        "".concat(envOptions.startTime),
        "-to",
        "".concat(envOptions.endTime),
        "-loop",
        "".concat(userOptions.loop),
        "-vf",
        "fps=".concat(userOptions.fps, ",scale=").concat(userOptions.frameSize),
        ""
          .concat(envOptions.basename, "[")
          .concat(envOptions.startTime.toFixed(), "-")
          .concat(envOptions.endTime.toFixed(), "]")
          .concat(picType),
      ];
    }
    print(commands.join(" "));
    mp.command_native_async(
      {
        name: "subprocess",
        playback_only: false,
        args: commands,
        capture_stdout: true,
      },
      function (success, result, err) {
        if (success) {
          mp.msg.info(
            "generate "
              .concat(picType, ":")
              .concat(envOptions.filename, " succeed")
          );
          mp.osd_message(
            "generate "
              .concat(picType, ":")
              .concat(envOptions.filename, " succeed")
          );
        } else {
          mp.msg.warn(
            "generate "
              .concat(picType, ":")
              .concat(envOptions.filename, " failed")
          );
          mp.osd_message(
            "generate "
              .concat(picType, ":")
              .concat(envOptions.filename, " failed")
          );
        }
      }
    );
    if (userOptions.audio) {
      cutAudio();
    }
  }
  function getExt(filename) {
    var splitIndex = filename.lastIndexOf(".");
    var res = filename.substring(splitIndex + 1);
    dump("res", res);
    return res;
  }
  function cutAudio() {
    if (!validateTime()) {
      return;
    }
    var AudioType = getAudioType();
    var commands;
    commands = [
      "ffmpeg",
      "-v",
      "warning",
      "-accurate_seek",
      "-i",
      "".concat(envOptions.filename),
      "-ss",
      "".concat(envOptions.startTime),
      "-to",
      "".concat(envOptions.endTime),
      "-vn",
      "-acodec",
      "copy",
      ""
        .concat(envOptions.basename, "[")
        .concat(envOptions.startTime.toFixed(), "-")
        .concat(envOptions.endTime.toFixed(), "].mka"),
    ];
    print(commands.join(" "));
    mp.command_native_async(
      {
        name: "subprocess",
        playback_only: false,
        args: commands,
        capture_stdout: true,
      },
      function (success, result, err) {
        if (success) {
          mp.msg.info("cut audio succeed");
          mp.osd_message("Cut Audio Succeed.");
        } else {
          mp.msg.warn("cut audio failed");
          mp.osd_message("Cut Audio Failed.");
        }
      }
    );
  }
  function cutVideo() {
    if (!validateTime()) {
      return;
    }
    var commands = [
      "ffmpeg",
      "-v",
      "warning",
      "-accurate_seek",
      "-i",
      "".concat(envOptions.filename),
      "-ss",
      "".concat(envOptions.startTime),
      "-to",
      "".concat(envOptions.endTime),
      "-c",
      "copy",
      ""
        .concat(envOptions.basename, "[")
        .concat(envOptions.startTime.toFixed(), "-")
        .concat(envOptions.endTime.toFixed(), "].")
        .concat(getExt(envOptions.filename)),
    ];
    print(commands.join(" "));
    mp.command_native_async(
      {
        name: "subprocess",
        playback_only: false,
        args: commands,
        capture_stdout: true,
      },
      function (success, result, err) {
        if (success) {
          mp.msg.info("cut video succeed");
          mp.osd_message("Cut Video Succeed ");
        } else {
          mp.msg.warn("cut video failed");
          mp.osd_message("Cut Video failed ");
        }
      }
    );
  }
  function generateGif() {
    geneRateAnimatedPic(animatePicType.gif, false);
  }
  function generateGifWithSub() {
    geneRateAnimatedPic(animatePicType.gif, true);
  }
  function generateWebp() {
    geneRateAnimatedPic(animatePicType.webp, false);
  }
  function generateWebpWithSub() {
    geneRateAnimatedPic(animatePicType.webp, true);
  }
  mp.add_key_binding("g", "setStartTime", setStartTime);
  mp.add_key_binding("G", "setEndTime", setEndTime);
  mp.add_key_binding("Ctrl+g", "generateGif", generateGif);
  mp.add_key_binding("Ctrl+G", "generateGifWithSub", generateGifWithSub);
  mp.add_key_binding("Ctrl+w", "generateWebp", generateWebp);
  mp.add_key_binding("Ctrl+W", "generateWebpWithSub", generateWebpWithSub);
  mp.add_key_binding("Ctrl+a", "cutAudio", cutAudio);
  mp.add_key_binding("Ctrl+v", "cutVideo", cutVideo);
  mp.register_event("file-loaded", initEnvOptions);
})(mp);
