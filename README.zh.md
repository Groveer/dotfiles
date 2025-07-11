# 个人配置

<a id="top"></a>

[English](README.md) | 中文

## Themes

<div align="center">

![hyde_banner](https://raw.githubusercontent.com/prasanthrangan/hyprdots/main/Source/assets/hyde_banner.png)

<br>

https://github.com/prasanthrangan/hyprdots/assets/106020512/7f8fadc8-e293-4482-a851-e9c6464f5265

<br></div>

<div align="right">
  <br>
  <a href="#top"><kbd> <br>  <br> </kbd></a>
</div>

**在 Archlinux 上可以拥有与本人一致的体验**

## Desktop Environment（Native Wayland）

**在 Archlinux 上安装包（需要 aur）:**

一些工具可以通过`cargo/pip/npm`等工具来安装。

1. shell

```bash
yay -S zsh eza rsync bat starship htop jq fastfetch kitty
```

```bash
chsh -s /bin/zsh
```

2. fonts

Download fonts from here: [MapleMono-NF-CN.zip](https://github.com/subframe7536/Maple-font/releases)

```bash
wget https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-NF-CN-unhinted.zip   # screen > 1080p
wget https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-NF-CN.zip            # screen <= 1080p
unzip MapleMono-NF-CN.zip -d MapleFont
sudo cp -r MapleFont /usr/share/fonts
sudo fc-cache -fv
```

3. hypr

```bash
yay -S dunst libnotify hyprland rofi-wayland waybar swww swaylock-effects grimblast-git cliphist pipewire-pulse swappy wf-recorder swayidle
```

4. dependency

```bash
yay -S polkit-gnome xdg-desktop-portal-hyprland parallel imagemagick qt5-imageformats brightnessctl pavucontrol pamixer pacman-contrib
```

5. theme

```bash
yay -S nwg-look kvantum qt5ct qt6ct qt5-wayland qt6-wayland
```

6. apps

```bash
yay -S google-chrome/firefox/zen-browser fcitx5-chinese-addons
```

7. others

```bash
python -m venv ~/.venv
```

```bash
pip install hyprshade
```

如果使用amdgpu，可以安装：

```bash
pip install pyamdgpuinfo
```

## 初始化

1. 安装上面所有的包。
2. 运行 `./config.sh install`, 它会初始化环境变量，并且创建软链。
3. 运行 `chsh -s /bin/zsh`, 切换终端.
4. 重新登录并且运行 `startde w`.
5. 运行`./init.sh`脚本，它会初始化环境变量并且释放资源。
6. 如果在运行过程中发现在家目录有冲突文件，请手动删除它，然后运行：`./config.sh install`。

> [!IMPORTANT]
> 运行`./init.sh`脚本会自动运行`./config.sh install`，该脚本会删除您的`~/.bashrc`文件，请在运行前备份好它！

## 运行

在 tty 中执行`startde w`。

## 更新

```bash
./config.sh uninstall
git pull --rebase
./config.sh install
```

## 卸载

非常简单的删除初始化过程中创建的符号，只需要运行：`./config.sh uninstall`。

## 编辑器 (Neovim)

### 开发环境 (Neovim 配置依赖)

安装包：

```bash
yay -S python npm
```

初始化 python：

```bash
python -m venv ~/.venv
```

Python 新版本升级时，可用命令升级：

```bash
python -m venv --upgrade ~/.venv
```

安装 rust：

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup sh
```

更新 rust：

```bash
rustup update stable
```

重启终端以应用的环境变量，使用`./config.sh install`脚本会自动使用国内源：

`pip`和`npm`只是 neovim 基本的环境配置，强烈建议跑完 lua 的配置后使用`:checkhealth`命令查看哪些命令未安装，可继续使用相应的包管理进行安装！

### 安装 neovim 配置

默认使用 ssh 协议，如果使用 http 协议，需要修改`.gitmodules`文件，设置`url`为:

```txt
https://github.com/groveer/nvvim.git
```

更新 git 子模块:

```bash
git submodule update --init
```

<div align="right">
  <br>
  <a href="#top"><kbd> <br>  <br> </kbd></a>
</div>

## Thanks to

1. [hyprdots](https://github.com/prasanthrangan/hyprdots)：主题来源于这里！
