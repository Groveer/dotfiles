# 私人配置

## 常用软件配置

### 桌面环境（sway + waybar + swaylock）

#### 简介

Sway 是一款专为 Wayland 设计的合成器，旨在与 i3 完全兼容。所以配置和使用习惯上和 i3 的区别不大，但是由于 sway 是完全原生的 wayland 合成器，所以相较于基于 X11 协议的 i3wm，完全没有屏幕撕裂！！！而且对于像 2K、3K、4K 这些高分辨率（hiDPI）的屏幕，sway 的支持更好。我自己体验下来，sway 的整体视觉观感、字体渲染确实比 i3wm 好很多。

#### 安装

本人使用的是 Archlinux，所以以下安装包在 Archlinux 中绝对是可以找到的，其他发行版请自行摸索，或使用其他桌面环境。

1. 要完全使用 sway 桌面环境，需安装以下包。

```bash
nerd-fonts-complete waybar wofi polkit-gnome sway-im wl-clipboard swayidle swaylock brightnessctl playerctl grim slurp mako xdg-desktop-portal-wlr
```
2. 要使用基本环境，只需安装部分包。

* `sway-im`：该包在 aur 仓库中，官方仓库是`sway`这个包，使用`sway-im`的原因是它对输入法更友好，支持候选栏展示，而官方版本却没有这个功能。
* `waybar`：一般叫做状态栏或者 dock 栏，一般放在屏幕上方或下方，它支持`css`样式。
* `wofi`：`sway`环境下的启动器，用于替代`X11`环境中的`rofi`。
* `wl-clipboard`：`wayland`环境中的复制粘贴工具，本人`sway`配置中必须使用这个包。
* `polkit-gnome`：鉴权窗口，部分应用需要提权操作，而`sway`的启动必须要`polkit`服务或`seatd`服务。

3. 其他的包视个人需求进行安装，但还是建议全部安装
* `mako`：`sway`环境下的消息通知。
* `swayidle`：空闲管理，配合`swaylock`当系统空闲时进行锁屏。
* `swaylock`：同上。
* `xdg-desktop-portal-wlr`：一套前端桌面的标准协议，由于`sway`基于`wrtools`开发，所以使用这个包，对应的还有`gnome`、`kde`、`gtk`等。
* `grim`：`wayland`环境下的截图程序，配合`slurp`使用可以自定义截图区域。
* `slurp`：同上。
* `brightnessctl`：屏幕背光的命令行控制程序。
* `playerctl`：媒体播放器的命令行控制程序。

#### sway

1. 配置`wezterm`为默认终端。
2. 默认启动小键盘输入。
3. 默认启用触摸板。
4. 使用`wofi`作为启动器。
5. 使用`grim`+`slurp`来实现方便快速的截图功能。
6. 使用`wl-clipboard`来实现方便的复制功能。
7. 快捷键的配置请参考[配置文件](sway/config)。
8. `sway`完全配置参考[官方文档](https://github.com/swaywm/sway/wiki)。

#### waybar

包含显示的项目：

1. cpu usage
2. gpu usage 每个电脑都不同，需根据个人电脑自行配置。
2. memory
3. temprature 每个电脑都不同，需根据个人电脑自行配置。
4. workspace
5. tray
6. pulseaudio
7. network
8. battery
9. clock
10. `waybar`完全配置参考[官方文档](https://github.com/Alexays/Waybar/wiki/Configuration)。

#### wofi

主要配置一些`css`样式，熟悉 css 的同学可以自行配置。

### 终端环境（zsh + wezterm）

#### zsh

本人并未使用`oh-my-zsh`这种比较重量级的配置工具，而是使用 powerlevel10k 主题和几个插件。

在 Archlinux 中可以安装以下包并在`~/.zshrc`中进行配置：
```bash
zsh-theme-powerlevel10k zsh-syntax-highlighting zsh-autosuggestions
```
配置：
```bash
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```
在其他发行版上可直接从 github 上下载对应的插件：
```bash
mkdir -p ~/.zsh/plugins
cd ~/.zsh/plugins
git clone https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```

配置：
```bash
source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

另外，还设置一些 alias，替代了一些工具：

* exa 替代 ls 和 tree
* bottom 替代 top
* bat 替代 cat
* rsync 替代 cp

关于`~/.zprofile`：

仅仅是设置登录`tty1`自动启动`sway`桌面，关于如何开机自动，请参考[这里](https://groveer.github.io/book/linux/auto-login.html)

#### wezterm

`wezterm`的配置文件在`~/.config/wezterm/wezterm.lua`，配置文件可用`stow`进行软链，这里对wezterm进行了简单的配置，主要是透明背景。

### 浏览器（firefox）

使用火狐浏览器的好处是个人配置与历史记录完美同步，关于配置，每个人都不一样，这里不再过多介绍。需要注意的是，火狐浏览器虽然原生支持wayland，但默认并未使用wayland原生，需要修改环境变量以启用，关于wayland环境配置，可参考[这里](https://groveer.github.io/book/archlinux/config.html#%E9%85%8D%E7%BD%AEwayland%E7%8E%AF%E5%A2%83)

### 编辑器/IDE（neoview）

Neovim 既是编辑器又是 IDE，具体配置可参考[这里](nvim/README.md)

### 管理dotfiles

1. 本人使用`stow`来管理 dotfiles，好处是配置文件全部集中在本项目中，只需修改本项目内容即可方便快速的部署 dotfiles 并使其生效，其原理就是在对应的目录中创建软链。
2. 以`zsh`为例，首先删除用户目录中原来的`.zprofile`和`.zshrc`文件，然后执行：`stow zsh -t ~`。
3. 以`nvim`为例，首先删除用户目录中原来的配置：`rm -rf ~/.config/nvim/*`，记住不要删除文件夹，没有文件夹也需要先创建，然后执行：`stow nvim -t ~/.config/nvim`。
4. 因为是软链，如果新增或删除文件，都需要重新软链，但是修改不需要，删除：`stow -D nvim -t ~/.config/nvim`，重新软链：`stow nvim -t ~/.config/nvim`。
5. 若是有兴趣的同学也可以写成脚本更方便的进行更新管理。
