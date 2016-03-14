# Set up the prompt
autoload -Uz promptinit
promptinit
prompt off
PS1=' %~ 
%# '
bindkey -v

setopt autocd
setopt hist_ignore_all_dups
setopt hist_ignore_space
#Kaynak: http://wiki.gentoo.org/wiki/Zsh/HOWTO
setopt dotglob
setopt histignorealldups sharehistory
# append to the history file, don't overwrite it
setopt histappend
# isaretini comment olarak yorumlasin.
set -k
#set DISPLAY :0.0

#echo -e '\033[?17;0;127c']'
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000000
SAVEHIST=100000000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit -D

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
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
zstyle ':completion:*:hosts' hosts _ssh_config 
[[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config

eval "$(dircolors -b)"
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# # See bash(1) for more options
HISTCONTROL=ignoreboth

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color) color_prompt=yes;;
#esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
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

if [ -f ~/.zsh/zsh_aliases ]; then
    . ~/.zsh/zsh_aliases
fi

# load exports
if [ -f ~/.zsh/zsh_exports ]; then
  source ~/.zsh/zsh_exports
fi

#zargan
zl(){
        z $@ | head -10
}
zz(){
        z $@ | more
}
#man() {
#        env \
#        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#                LESS_TERMCAP_md=$(printf "\e[1;31m") \
#                LESS_TERMCAP_me=$(printf "\e[0m") \
#                LESS_TERMCAP_se=$(printf "\e[0m") \
#                LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#                LESS_TERMCAP_ue=$(printf "\e[0m") \
#                LESS_TERMCAP_us=$(printf "\e[1;32m") \
#                        man "$@"
#}

uncomment() {
sed -e 's/#.*//' -e 's/[ ^I]*$//' -e '/^$/ d' $1
}
#source $HOME/bin/sshag.sh >/dev/null 2>&1
eval "$(fasd --init auto)"
eval `dircolors /home/orkung/Git_Repolari/diger/dircolors-solarized/dircolors.256dark`
alias x='ssh-agent startx'
compdef _task t='task'

# Initialize colors.
autoload -U colors
colors
 
# Allow for functions in the prompt.
setopt PROMPT_SUBST
 
# Autoload zsh functions.
fpath=(${HOME}/.zsh/functions $fpath)
autoload -U ~/.zsh/*(:t)
 
# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
 
# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
# 
## Set the prompt.
#PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)
#%#%{${fg[default]}%} '

#vman() {
#  vim -c "SuperMan $*"
#
#  if [ "$?" != "0" ]; then
#    echo "No manual entry for $*"
#  fi
#}
#
#compdef vman="man"
#complete -o default -o nospace -F _man vman

#eval "$(chef shell-init zsh)"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

#source /usr/local/bin/virtualenvwrapper.sh
#source ~/Git_Repolari/diger/sshag/sshag.sh; sshag &>/dev/null
#source ~/Git_Repolari/diger/sshag/sshag.sh >/dev/null 2>&1
#source ~/Git_Repolari/diger/sshag/sshag.sh

# OPAM configuration
# . /root/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#fzf-dmenu() { 
#    # note: xdg-open has a bug with .desktop files, so we cant use that shit
#    selected="$(ls /usr/share/applications | fzf -e)"
#    nohup `grep '^Exec' "/usr/share/applications/$selected" | tail -1 | sed 's/^Exec=//' | sed 's/%.//'` >/dev/null 2>&1&
#}



#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}


# hotkey to run the function (Ctrl+O)
#bindkey -s '^O' "fzf-dmenu\n"
#line_divider(){
#  echo "${(l.$COLUMNS..—.)}"
#}
fj() {
  local dir
  dir=$(fasd -Rdl | fzf --no-sort +m) && cd "$dir"
}
fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# ZSH keybinding example; ~/.zshrc
fzf_history() { 
  zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ; }; 
  zle -N fzf_history; bindkey '^F' fzf_history
fzf_killps() { zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; zle -N fzf_killps; bindkey '^Q' fzf_killps
fzf_cd() { zle -I; DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" ; }; zle -N fzf_cd; bindkey '^E' fzf_cd

#myvfm() {
#  zle -I; eval $(${EDITOR:-vim}$(fzf)); };
#  zle -N myvfm; bindkey '^W' myvfm
#  zle redisplay
#}
#zle     -N   myvfm
#bindkey '^W' myvfm
# rxvt-unicode-256color kullanilacaksa
case "$TERM" in
    rxvt-unicode-256color)
    TERM=rxvt-unicode
    ;;
esac
bindkey -s '^W' 'vim $(fzf)\n' 

PATH="/home/orkung/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/orkung/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/orkung/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/orkung/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/orkung/perl5"; export PERL_MM_OPT;
