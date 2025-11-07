#!/bin/bash

cur_path=$(pwd)
dot_cache=~/.cache/dotsave

declare -A dict

# key: part of path value: command
dict=(
    # desktop environment
    [niri]=niri
    [local]=niri
    [libinput]=niri
    [MangoHud]=mangohud
    [swaylock]=swaylock
    [dunst]=dunst
    [waybar]=waybar
    [rofi]=rofi
    ["nwg-look"]=nwg-look
    [themes]=nwg-look
    [xsettingsd]=nwg-look
    [swayidle]=swayidle
    # tools
    [nvim]=nvim
    [editorconfig]=nvim
    [fcitx5]=fcitx5
    [alacritty]=alacritty
    [mpv]=mpv
    [kitty]=kitty
    [ghostty]=ghostty
    [fastfetch]=fastfetch
    ["/.zsh"]=zsh
    ["/.ssh"]=ssh
    [fish]=fish
    [starship]=starship
    [gdb]=gdb
    [pip]=pip
    [npm]=npm
    [cargo]=cargo
    [chrome]=google-chrome-stable
    [chromium]=chromium
    [edge]=microsoft-edge-stable
    [nix]=nix
    ["home-manager"]=nix
)

get_dir() {
    for element in $(ls -A $1); do
        path="$1/$element"
        home_path=${path/"$cur_path/configs"/"$HOME"}
        if [[ $path =~ ".config/" ]] || [[ $path =~ ".bash_it/" ]] || [[ $path =~ ".themes/" ]] || [ -f $path ]; then
            parent_path=$(dirname $home_path)
            for key in ${!dict[@]}; do
                value=${dict[$key]}
                if [[ $path =~ $key ]] && command -v "${value}" >/dev/null 2>&1; then
                    [ ! -d $parent_path ] && mkdir -p $parent_path && echo mkdir -p $parent_path done!
                    [ -d $path ] && [ -d $home_path ] && rm -rf $home_path && rm -rf $home_path done!
                    ln -sf $path $home_path && echo "ln -sf $path $home_path done!"
                    echo $home_path >>$dot_cache
                    break
                fi
            done
            # echo $target
            if [[ $path =~ $key ]]; then
                continue
            fi
        fi

        if [ -d $path ]; then
            get_dir $path
        fi
    done
}

if [ $1 == "install" ]; then
    rm $dot_cache
    get_dir "$cur_path/configs"
fi

if [ $1 == "uninstall" ]; then
    while read line; do
        rm -rf $line && echo "rm -rf $line done!"
    done <$dot_cache
fi
