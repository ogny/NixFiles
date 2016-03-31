#!/bin/bash

#BATTINFO=`acpi -b`
#if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:15:00 ]] ; then
#    DISPLAY=:0.0 /usr/bin/notify-send "low battery" "$BATTINFO"
#fi

BATTINFO=$(egrep -wir "POWER_SUPPLY_CAPACITY" /sys/class/power_supply/BAT0/uevent |cut -d= -f2)
if (( `echo $BATTINFO` < 15 )) ; then
  DISPLAY=:0.0 /usr/bin/notify-send "low battery" "$BATTINFO"
fi
