#!/bin/bash
ps -efd |grep  "/opt/google/chrome/chrome" &> /dev/null
if [ $? == 0 ]; then
/usr/bin/notify-send "Google Drive'i oldur"
fi
