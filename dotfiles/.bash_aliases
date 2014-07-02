alias z='~/bin/zargan.py'
alias rdsktp='rdesktop -u administrator -g 1920x1080 10.10.18.111'
alias ntstat='sudo netstat -taunp |egrep *:80'
alias perms='find . -type d -exec chmod 0755 {} \; && find . -type f -exec chmod 0644 {} \;'
alias mr='mtr -s 1500 -r -c 1000 -i 0.1 $@'
alias bagli='lsof -P -i -n'
alias pp='ps aux | grep -v grep | grep $1 '
alias mem='ps -A --sort -rss -o comm,pmem | head -n 11'
#alias vim="LC_ALL=en_US.UTF-8 vim"
alias dv="du --max-depth=1 -k | sort -nr | head -11 |cut -f2 | xargs -d '\n' du -sh 2>/dev/null"
alias key="xmodmap -pke |grep $@"
#alias tr='setxkbmap tr -variant alt'
alias tur='setxkbmap tr'
alias us='setxkbmap us && xmodmap ~/.Xmodmap'
alias nm='nmap -T4 -A -v -PE -PS22,25,80 -PA21,23,80,3389 $@'
alias ll='ls -alh'
alias uzers='sudo cat /etc/passwd | cut -d":" -f1'
alias nt=" netstat -anoep --inet |grep $@"
alias upd="sudo aptitude update"
alias upg="sudo aptitude upgrade"
alias api="sudo aptitude install"
alias se="sudo dpkg --get-selections"
alias aps="sudo apt-cache --names-only search"
alias sht='sudo shutdown -h now'
alias vr='sudo vim'
alias enable_alert='PS1="$PS1\a"'
alias rake='noglob rake'
alias disk_test='dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync'
alias ls='ls --color=auto'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ll="ls -alh |awk '{print$9}'"
