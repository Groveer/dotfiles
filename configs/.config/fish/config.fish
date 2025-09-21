function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

# base env
set PATH ~/.local/bin $PATH

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr -a mkdir mkdir -p

if command -s vim > /dev/null
  set -x EDITOR vim
end
if command -s nvim > /dev/null
  set -x EDITOR nvim
end
if command -s neovide > /dev/null
  abbr -a nvim neovide
end
if command -s eza > /dev/null
  abbr -a ls eza --icons=auto
  abbr -a l eza -al --icons=auto
  abbr -a ll eza -l --icons=auto
  abbr -a tree eza -T --icons=auto
end
if command -s bat > /dev/null
  abbr -a cat bat -p
end
if command -s rsync > /dev/null
  abbr -a cp rsync -avP
end

function date-changelog
  env LC_ALL=C date +'%a, %d %b %Y %T %z'
end

# deepin setting
function deepin-env-on
  set -Ux QT_QPA_PLATFORMTHEME deepin
  set -Ux QT_STYLE_OVERRIDE chameleon
end

function deepin-env-off
  set -Ux QT_QPA_PLATFORMTHEME qt5ct
  set -e QT_STYLE_OVERRIDE
end

# cargo env
if command -s cargo > /dev/null || test -d $HOME/.cargo/bin/
  set PATH $HOME/.cargo/bin $PATH
end

# fnm config
if command -s fnm > /dev/null
  fnm env --use-on-cd | source
end

# go env
if command -s go > /dev/null
  set -x GOROOT /usr/lib/go
  set -x GOPATH $HOME/go
  if test -d /usr/share/gocode
    set -x GOPATH /usr/share/gocode $GOPATH
  end
	set -x GOBIN $HOME/go/bin
	set -x PATH $GOROOT/bin $GOBIN $PATH
	set -x GO111MODULE auto
	set -x GOPROXY https://goproxy.cn,direct
end

# qt6 env
if test -d /usr/lib/qt6/bin
  set PATH /usr/lib/qt6/bin $PATH
end

# latex env
if test -d /usr/local/texlive
  set -x MANPATH /usr/local/texlive/2023/texmf-dist/doc/man $MANPATH
  set -x INFOPATH /usr/local/texlive/2023/texmf-dist/doc/info $INFOPATH
  set -x PATH /usr/local/texlive/2023/bin/x86_64-linux $PATH
end

test -f "/usr/share/plantuml/plantuml.jar" && set -x PLANTUML_JAR "/usr/share/plantuml/plantuml.jar"
test -f "/usr/share/java/plantuml/plantuml.jar"  && set -x PLANTUML_JAR "/usr/share/java/plantuml/plantuml.jar"
if command -s lualatex > /dev/null
  abbr -a llatex lualatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error
end

# pythen venv
set -l venv_path $HOME/.pyenv/bin
test -d $venv_path && fish_add_path $PYENV_ROOT/bin

if command -s pyenv > /dev/null
  pyenv init - | source
end

# freerdp
if command -s wlfreerdp > /dev/null
  function wlrdp
	wlfreerdp +compression +clipboard -themes -wallpaper -grab-keyboard /gdi:hw /drive:Downloads,$HOME/Downloads $argv /dynamic-resolution /mic /audio-mode:0
  end
end

if command -s starship > /dev/null
  starship init fish | source
end

if command -s zoxide > /dev/null
  zoxide init fish | source
end

if status is-login
  exec bash -c "test -e /etc/profile && source /etc/profile;\
  exec fish"
end

#if test (tty) = "/dev/tty1" -a -z "$DISPLAY"
#  startde w
#end
# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end

