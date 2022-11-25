export PATH=$PATH:~/.local/bin
export EDITOR=vim

# export http_proxy=http://127.0.0.1:7890
# export https_proxy=$http_proxy
# export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

# need neovim package
if [ -x "/usr/bin/nvim" ]; then
    alias vim=nvim
fi

# need exa package
if [ -x "/usr/bin/exa" ]; then
    alias ls="exa --icons"
    alias l="exa -al --icons"
    alias ll="exa -l --icons"
    alias tree="exa -T --icons"
fi

# need bat package
if [ -x "/usr/bin/bat" ]; then
    alias cat="bat"
fi

# if debian need batcat
if [ -x "/usr/bin/batcat" ]; then
    alias cat="batcat"
fi

# need rsync package
if [ -x "/usr/bin/rsync" ]; then
    alias cp="rsync -avP"
fi

