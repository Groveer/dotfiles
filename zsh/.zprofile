if [[ -x ~/.local/bin/startde && -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
   exec startde
fi
