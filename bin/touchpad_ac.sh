#!/bin/bash
#id=`xinput list |grep PS/2 |awk '{print$6}' |cut -d= -f2`
#xinput set-prop $id 'Device Enabled' 1
synclient TouchpadOff=0
