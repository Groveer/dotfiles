if [[ -x /usr/bin/sway && -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
   exec sway
fi
