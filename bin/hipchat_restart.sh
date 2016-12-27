#!/bin/bash
set -e
#ps -efd |grep /usr/bin/hipchat |grep -v grep 
#CALISTIR=$(LIBGL_ALWAYS_SOFTWARE=1 /usr/bin/hipchat &)
##CALISTIR=$(LIBGL_ALWAYS_SOFTWARE=1 hipchat &)
#if [ $? -eq 0 ];
#then
#  exit 0
#else
#  $CALISTIR >/dev/null 2>&1
#fi >/dev/null 2>&1



CALISTIR=$(LIBGL_ALWAYS_SOFTWARE=1 /usr/bin/hipchat >/dev/null 2>&1)
ps -efd |grep /usr/bin/hipchat |grep -v grep
RESULT=$?
if [ $RESULT -eq 0 ]; then
  exit 0
else
# $CALISTIR  
  LIBGL_ALWAYS_SOFTWARE=1 /usr/bin/hipchat >/dev/null 2>&1
fi

