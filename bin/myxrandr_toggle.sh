#!/bin/bash

# get info from xrandr
activeOutput=$(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")

# initialize variables

i=1
switch=0

  # build default configuration
if [ $i -eq 1 ]
  then
   xrandr --output $activeOutput --off 
   switch=0
# else
#  xrandr --output $activeOutput --auto
#  switch=1
fi
