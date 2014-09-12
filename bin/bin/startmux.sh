#!/bin/bash
PID=$(pgrep tmux)
new="tmux -f $HOME/.tmux/conf new -s secured"
old="tmux attach -t secured -d"

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval `ssh-agent`
    trap "kill $SSH_AGENT_PID" 0
fi

if [[ -z "$PID" ]]; then
    urxvt -title "SSH" -e sh -c "${new}"
else
    urxvt -title "SSH" -e sh -c "${old}"
fi

ssh-add
