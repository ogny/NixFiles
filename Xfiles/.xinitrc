#exec setxkbmap -option caps:escape
#exec ssh-agent zsh
#exec xmodmap /home/orkung/.Xmodmap
#exec i3
xset s off -dpms
setxkbmap -option caps:escape
#exec /home/orkung/bin/clipd
exec i3 --shmlog-size=26214400
