#===================== Base Configuration Start =====================
bindkey -e # 使用Emacs风格的键绑定

HISTSIZE=10000      # 内存中保存的历史记录条目数
SAVEHIST=10000      # 保存在文件中的历史记录条目数
HISTFILE=${HOME}/.history

setopt APPEND_HISTORY            # 追加历史记录而不是覆盖
setopt HIST_IGNORE_DUPS          # 忽略重复的命令
setopt SHARE_HISTORY             # 共享历史记录，多个终端会话同步
setopt HIST_REDUCE_BLANKS        # 去除历史记录中多余的空格
setopt HIST_EXPIRE_DUPS_FIRST    # 当历史记录超出限制时，优先删除重复条目

if [[ "$PATH" != *"$HOME/.local/bin"* ]]; then
    export PATH=$HOME/.local/bin:$PATH
fi

if [ -e ${HOME}/.nix-profile/etc/profile.d/nix.sh ] && [[ "$PATH" != *"nix"* ]]; then
    . ${HOME}/.nix-profile/etc/profile.d/nix.sh
fi

if [ -e ${HOME}/.local/lib/node_modules/bin ] && [[ "$PATH" != *"node_modules"* ]]; then
    export PATH=${HOME}/.local/lib/node_modules/bin:$PATH
fi
if test -d "/opt/nvim-linux64/bin" && [[ "$PATH" != *"nvim"* ]]; then
    export PATH="$PATH:/opt/nvim-linux64/bin"
fi

alias mkdir="mkdir -pv"

if command -v rsync >/dev/null; then
    alias cp="rsync -azvP"
fi

if command -v vim >/dev/null; then
    export EDITOR=vim
fi
if command -v nvim >/dev/null; then
    export EDITOR=nvim
fi

date-changelog() {
    env LC_ALL=C date +'%a, %d %b %Y %T %z'
}

if [[ -d ${HOME}/.cargo/bin ]] && [[ "$PATH" != *"cargo/bin"* ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if command -v eza >/dev/null; then
    alias ls="eza --icons=auto"
    alias l="ls -al"
    alias ll="ls -l"
    alias tree="ls -T"
fi
if command -v bat >/dev/null; then
    alias cat="bat -p"
fi
if command -v paru >/dev/null; then
    alias pu="paru"
fi

if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
fi
if command -v fnm >/dev/null && [[ "$PATH" != *"fnm"* ]]; then
    eval "$(fnm env --use-on-cd)"
fi
if [[ -d /usr/lib/qt6/bin ]] && [[ "$PATH" != *"qt6/bin"* ]]; then
    export PATH="/usr/lib/qt6/bin/:$PATH"
fi
if [[ -d ${HOME}/.venv ]] && [[ "$PATH" != *"venv"* ]]; then
    source ${HOME}/.venv/bin/activate
fi

if test -d /usr/local/texlive; then
    export MANPATH="/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH"
    export INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"
    export PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
fi
test -f "/usr/share/plantuml/plantuml.jar" && export PLANTUML_JAR="/usr/share/plantuml/plantuml.jar"
test -f "/usr/share/java/plantuml/plantuml.jar" && export PLANTUML_JAR="/usr/share/java/plantuml/plantuml.jar"
if command -v lualatex >/dev/null; then
    alias llatex="lualatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error"
fi

### for install zinit:
# bash -c "$(curl --fail --show-error --silent --location https://gh.api.99988866.xyz/https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/history-search-multi-word \
    skywind3000/z.lua

### End of Zinit's installer chunk

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions
#===================== Base Configuration End =======================

#===================== User Configuration Start =====================

if command -v distcc >/dev/null && [[ "$PATH" != *"distcc"* ]]; then
    export PATH="/usr/lib/distcc/bin/:$PATH"
fi

# export RUSTC_WRAPPER=/usr/bin/sccache

#===================== User Configuration End =======================
