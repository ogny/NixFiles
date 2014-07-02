alias za='~/Dropbox/bin/zargan.py'
alias rdsktp='rdesktop -u administrator -g 1920x1080 10.10.18.111'
alias ntstat='sudo netstat -taunp |egrep *:80'
alias shuttle='sudo sshuttle -r beyaz@85.111.24.158:30022 10.44.0.0/16 172.44.0.0/16 0/0 -x 10.10.0.0/16 --dns'
alias perms='find . -type d -exec chmod 0755 {} \; && find . -type f -exec chmod 0644 {} \;'
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'
alias mr='mtr -s 1500 -r -c 1000 -i 0.1 $@'
alias moc='sudo mocp -T transparent-background'
alias bagli='lsof -P -i -n'
alias pp='ps aux | grep -v grep | grep $1 '
alias mem='ps -A --sort -rss -o comm,pmem | head -n 11'
alias ls='ls --color=auto'
alias vim="LC_ALL=en_US.UTF-8 vim"
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
alias ses='sudo alsamixer'
alias enable_alert='PS1="$PS1\a"'
alias rake='noglob rake'
#alias evxrandr='xrandr --output LVDS1 --mode 1360x768 --pos 0x0 --output VGA1 --mode 1920x1080 --pos 1360x0'
alias evxrandr='xrandr --output LVDS-1 --mode 1366x768 --pos 0x0 --output VGA-1 --mode 1920x1080 --pos 1360x0'
alias disk_test='dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync'
alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open
alias ls='ls --color=auto'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ll="ls -alh |awk '{print\$9}'"
