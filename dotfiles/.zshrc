# Set up the prompt
autoload -Uz promptinit
promptinit
prompt off
PS1=' %~ 
%# '
bindkey -v

setopt dotglob
setopt histignorealldups sharehistory
# append to the history file, don't overwrite it
setopt histappend
# isaretini comment olarak yorumlasin.
set -k

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u' 
zstyle ':completion:*:*:task:*' group-name ''

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# # See bash(1) for more options
HISTCONTROL=ignoreboth

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    alias ls='ls --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#zargan
zl(){
        z $@ | head -10
}
zz(){
        z $@ | more
}
man() {
        env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
                LESS_TERMCAP_md=$(printf "\e[1;31m") \
                LESS_TERMCAP_me=$(printf "\e[0m") \
                LESS_TERMCAP_se=$(printf "\e[0m") \
                LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
                LESS_TERMCAP_ue=$(printf "\e[0m") \
                LESS_TERMCAP_us=$(printf "\e[1;32m") \
                        man "$@"
}
uncomment() {
sed -e 's/#.*//' -e 's/[ ^I]*$//' -e '/^$/ d' $1
}
genpasswd() {
        local l=$1
        [ "$l" == "" ] && l=16
        /usr/bin/tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}
diig () {
dig NS `echo "$1" |sed 's/\.hosts//g' `
}
dg () {
dig +nocmd $1 any +multiline +noall +answer `echo "$1" |sed 's/\.hosts//g' `
}
dgg () {
dig +nocmd $1 any +multiline +noall +answer `echo "$1" |sed 's/pri\.//g' `
}
whoz () {
whois `echo "$1" |sed 's/pri\.//g' ` |grep "Registrant Name:" 
}
whos () {
whois `echo "$1" |sed 's/pri\.//g' ` |grep "Name Server:"
}
digg () {
dig +nocmd $1 any +multiline +noall +answer `echo "$1" `
}
lm () {
find $1 -maxdepth 1 -type f -printf '%f\n'
}
export PATH="$PATH:/home/orkung/bin:/usr/local/bin"
export VAGRANT_HOME=/home/orkung/.vagrant.d
export SSH_AGENT_SOCK=`~/bin/sshag.sh`
source ~/bin/sshag.sh >/dev/null 2>&1
eval "$(fasd --init auto)"
export MANPAGER=/home/orkung/bin/manpager.sh
alias top10="history | awk {'print $2'} | sort | uniq -c | sort -nr | head -n 10"
#source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=$HOME/Envs
export PROJECT_HOME=$HOME/Devel
eval `dircolors ~/Git_Repolari/diger/dircolors-solarized/dircolors.256dark`
alias x='ssh-agent startx'
export GPGKEY=2D8400B5
export GPG_TTY=$(tty)
# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath) 
alias t='task'
compdef _task t='task'
alias wrk='task work pro:work'
alias cmp='task comp pro:comp'
alias cmpad='task add pro:comp pri:M'
alias wrkad='task add pro:work pri:M'
