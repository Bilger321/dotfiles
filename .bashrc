# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Enable X forwarding of color settings to putty.
export TERM=xterm-256color

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Screen is dead, long live tmux
# Uncomment this block if you're using screen:
# qq() {
#         SCREEN_TITLE=$1
#         #PORT_NUMBER=$2
#         #PORT_NUMBER=$(echo -e "$PORT_NUMBER" | tr -d "p" | tr -d "-")
#         #echo "$PORT_NUMBER"
#  screen -t "$SCREEN_TITLE" -- bash -ic "unset ssh; ssh -v $1"
# }

# Quick shortcut for "Open new ssh session in tmux window named 'IP' " (tmux)
qq() {
    WINDOW_TITLE=$1
    tmux new-window -n "$WINDOW_TITLE" "exec ssh -v $1"
}

# Enables IP autocompletion for qq(). Can be applied to any command.
__complete_ssh_host() {
    local KNOWN_FILE=~/.ssh/known_hosts
    if [ -r $KNOWN_FILE ] ; then
        local KNOWN_LIST=`cut -f 1 -d ' ' $KNOWN_FILE | cut -f 1 -d ',' | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"`
    fi

    local CONFIG_FILE=~/.ssh/config
    if [ -r $CONFIG_FILE ] ; then
        local CONFIG_LIST=`awk '/^Host [A-Za-z]+/ {print $2}' $CONFIG_FILE`
    fi

    local PARTIAL_WORD="${COMP_WORDS[COMP_CWORD]}";

    COMPREPLY=( $(compgen -W "$KNOWN_LIST$IFS$CONFIG_LIST" -- "$PARTIAL_WORD") )

    return 0
}

complete -F __complete_ssh_host qq

# Change dircolors if configured, currently configured for Nord colorscheme.
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

# Adding a space make aliases work.
alias sudo="sudo "
