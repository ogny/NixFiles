#!/bin/bash
ps -efd |grep  "/opt/google/chrome/chrome" &> /dev/null
if [ $? == 0 ]; then
notify-send Manuel "Google Drive'i oldur"
fi
