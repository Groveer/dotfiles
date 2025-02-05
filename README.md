# Personal Configurations

<a id="top"></a>

English | [中文](README.zh.md)

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

**You can have the same user experience as me in Archlinux**

## Desktop Environment（Native Wayland）

**Install packages in Archlinux (need aur):**

Some tools can also be installed from `cargo/pip/npm`.

1. shell

```bash
yay -S zsh eza rsync bat starship htop
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

3. utils

```bash
yay -S qt5-wayland qt6-wayland
```

4. hypr

```bash
yay -S dunst libnotify hyprland rofi-wayland waybar swww swaylock-effects wlogout grimblast-git cliphist pipewire-pulse swappy hyde-cli-git wf-recorder
```

5. dependency

```bash
yay -S polkit-gnome xdg-desktop-portal-hyprland parallel imagemagick qt5-imageformats brightnessctl pavucontrol pamixer pacman-contrib
```

6. theme

```bash
yay -S nwg-look kvantum qt5ct qt6ct
```

7. apps

```bash
yay -S google-chrome/firefox/zen-browser kitty fastfetch neovim fcitx5
```

8. others

```bash
pip install hyprshade
```

If you use amdgpu, can install:

```bash
pip install pyamdgpuinfo
```

## Init

1. Install all packages.
2. Run `./config.sh install`, it will initialize env.
3. Run `chsh -s /bin/zsh`.
4. Relogin user and run `startde w`.
5. Run `./init.sh`, it will patch sources.
6. If there is a conflicting file, delete it manually. run `./config.sh install`

> [!IMPORTANT]
> `./init.sh` will excuable `./config.sh install`. **It will rm your `~/.bashrc`, please backup your `~/.bashrc` first!**

## Run

run `startde w` in tty.

## Update

```bash
./config.sh uninstall
git pull --rebase
./config.sh install
```

## Uninstall

It is easy to rm the symbol, just run `./config.sh uninstall`

## Editor/IDE (Neovim)

### Developer Environment (Neovim config dependeies)

Install packages:

```bash
yay -S python fnm
```

Init python:

```bash
python -m venv ~/.python_venv
```

When after update python, can update venv:

```bash
python -m venv --upgrade ~/.python_venv
```

Install nodejs:

```bash
fnm install <version/--latest>
fnm default <version>
```

Install rust:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Update rust:

```bash
rustup update stable
```

Restart terminal will auto apply env.

`pip` and `npm` are just the basic environment configuration of neovim, it is highly recommended to use the `:checkhealth` command to see which commands are not installed after running the configuration of lua, you can continue to use the corresponding package management for installation!

### install neovim config

default use git ssh, if you use http, modify `.gitmodules`, set `url`:

```txt
https://github.com/groveer/nvvim.git
```

Update git submodule:

```bash
git submodule update --init
```

<div align="right">
  <br>
  <a href="#top"><kbd> <br>  <br> </kbd></a>
</div>

## Thanks to

1. [hyprdots](https://github.com/prasanthrangan/hyprdots): themes from here!
