setxkbmap -layout "tr" -variant "alt"
xmodmap ~/.Xmodmap
exec ck-launch-session i3 -V >> ~/.i3/i3log 2>&1
#exec openbox-session
