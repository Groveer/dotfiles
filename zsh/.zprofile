
if [ -d ${HOME}/.zprofile.d ]; then
  for i in ${HOME}/.zprofile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
   exec sway
fi
