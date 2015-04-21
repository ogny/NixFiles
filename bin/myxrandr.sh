#!/bin/bash
#xrandr --output VGA-0 --auto --right-of LVDS-0 --output LVDS-0 --auto
#xrandr --newmode "1440x900_60.00"  106.50  1440 1528 1672 1904  900 903 909 934 -hsync +vsync
#xrandr --addmode VGA-1 1440x900_60.00
#xrandr --output VGA-1 --mode 1440x900_60.00 --right-of LVDS-1 --output LVDS-1 --auto
#xrandr --output VGA-1 --auto --left-of LVDS-1 --output LVDS-1 --auto
#xrandr --output VGA-1 --auto --right-of LVDS-1 --output LVDS-1 --auto
xrandr --output LVDS-1 --auto --left-of VGA-1 --output VGA-1 --auto
