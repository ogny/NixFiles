#exec setxkbmap -option caps:escape
#exec ssh-agent zsh
#exec xmodmap /home/orkung/.Xmodmap
#exec i3
xset s off -dpms
setxkbmap -option caps:escape
#exec /home/orkung/bin/clipd
eval $(ssh-agent) 
#exec i3 --shmlog-size=26214400
exec i3
