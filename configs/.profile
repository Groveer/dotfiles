# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# ~/.local/bin is handled in the .zshrc-synced PATH section below

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi # added by Nix installer

if command -v cargo >/dev/null 2>&1; then
    . $HOME/.cargo/env
fi

# =========================================================================
# PATH synced 1:1 from ~/.zshrc (dotfiles/configs/.zshrc), POSIX-sh syntax.
export _PROFILE_LOADED=1
# Bash login shells (and `bash -lc` used by systemd user services such as
# pi-web) previously only saw /usr/bin/node and the system PATH.
# Prepend order is reversed vs .zshrc so the final PATH keeps the same order.
# =========================================================================

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# npm global bin (matches ~/.npmrc prefix=${HOME}/.local/lib/node_modules)
if [ -d "$HOME/.local/lib/node_modules/bin" ]; then
    PATH="$HOME/.local/lib/node_modules/bin:$PATH"
fi

# fnm: --use-on-cd 是 zsh 专用；bash 登录 shell 只要 default alias 就行。
if command -v fnm >/dev/null 2>&1; then
    if [ -n "${ZSH_VERSION-}" ]; then
        eval "$(fnm env --use-on-cd)"
    else
        eval "$(fnm env --shell bash)"
    fi
fi

if [ -d /usr/lib/qt6/bin ]; then
    PATH="/usr/lib/qt6/bin:$PATH"
fi

if [ -d /usr/local/texlive/2026/bin/x86_64-linux ]; then
    PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
fi

MASON_BIN_PATH="$HOME/.local/share/nvim/mason/bin"
if [ -d "$MASON_BIN_PATH" ]; then
    PATH="$MASON_BIN_PATH:$PATH"
fi

if [ -d "$HOME/.bun/bin" ] || [ -d "$HOME/.cache/.bun/bin" ]; then
    if [ -d "$HOME/.bun/bin" ]; then
        PATH="$HOME/.bun/bin:$PATH"
    fi
    if [ -d "$HOME/.cache/.bun/bin" ]; then
        PATH="$HOME/.cache/.bun/bin:$PATH"
    fi
fi

if [ -d /usr/lib/sccache/bin ]; then
    PATH="/usr/lib/sccache/bin:$PATH"
fi
if [ -d /usr/lib/icecc/bin ]; then
    PATH="/usr/lib/icecc/bin:$PATH"
fi
if [ -d /usr/lib/distcc/bin ]; then
    PATH="/usr/lib/distcc/bin:$PATH"
fi

# appended at the end, as in .zshrc
if [ -d /opt/nvim-linux64/bin ]; then
    PATH="$PATH:/opt/nvim-linux64/bin"
fi
