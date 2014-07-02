#xrandr --newmode  "1920x1080_59.90"  172.51  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
#xrandr --newmode "1920x1080_0.00"  -nan  1920 -2147483648 -2147483648 -2147483648  1080 1081 1084 1081  -HSync +Vsync
xrandr --newmode  "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120  -hSync +vsync
xrandr --addmode DP1 1920x1080_60.00
xrandr --output DP1 --mode 1920x1080_60.00
#xrandr --addmode DP1 1920x1080_59.90
#xrandr --output DP1 --mode 1920x1080_59.90
xmodmap ~/.Xmodmap
exec i3 

