if [ -x "/usr/bin/go" ]; then
    export GOROOT=/usr/lib/go
    export GOPATH=$HOME/go
    [ -d "/usr/share/gocode" ] && export GOPATH="$GOPATH:/usr/share/gocode"
    export GOBIN=$HOME/go/bin
    export PATH=$PATH:$GOROOT/bin:$GOBIN
    export GO111MODULE=auto
fi

