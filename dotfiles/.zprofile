#eval "$(gpg-agent --daemon)" >/dev/null 2>&1

# Invoke GnuPG-Agent the first time we login.
    # Does `~/.gpg-agent-info' exist and points to gpg-agent process accepting signals?
if test -f $HOME/.gpg-agent-info && \
    kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
    GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info | cut -c 16-`
else
    # No, gpg-agent not available; start gpg-agent
    eval `gpg-agent --daemon --no-grab --write-env-file $HOME/.gpg-agent-info`
fi
export GPGKEY=2D8400B5
export GPG_TTY=`tty`
export GPG_AGENT_INFO

