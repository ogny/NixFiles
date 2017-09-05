#!/bin/bash
#id=`xinput list |grep PS/2 |awk '{print$6}' |cut -d= -f2`
#xinput set-prop $id 'Device Enabled' 0
durum=$(synclient |grep TouchpadOff |awk '{print$3}')
if [ $durum = 0 ]
then
synclient TouchpadOff=1
else
synclient TouchpadOff=0
fi
