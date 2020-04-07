# .bashrc

# User specific aliases and functions

alias cp='cp -i'
alias ls='ls -alF'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

ssh() {
        screen -t "$*" -- /usr/bin/ssh -l root -p 1291 $*
}

qq() {
        SCREEN_TITLE=$1
        #PORT_NUMBER=$2
        #PORT_NUMBER=$(echo -e "$PORT_NUMBER" | tr -d "p" | tr -d "-")
        #echo "$PORT_NUMBER"
  screen -t "$SCREEN_TITLE" -- bash -ic "unset ssh; ssh -v -l root -p 1291 $*"
}
