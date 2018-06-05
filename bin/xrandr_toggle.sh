# get info from xrandr
connectedOutputs=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
activeOutput=$(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")

# initialize variables
execute="xrandr "
default="xrandr "
i=1
switch=0

for display in $connectedOutputs
do
  # build default configuration
  if [ $i -eq 1 ]
  then
    default=$default"--output $display --auto "
  else
    default=$default"--output $display --off "
  fi

  # build "switching" configuration
  if [ $switch -eq 1 ]
  then
    execute=$execute"--output $display --auto "
    switch=0
  else
    execute=$execute"--output $display --off "
  fi

  # check whether the next output should be switched on
  if [ $display = $activeOutput ]
  then
    switch=1
  fi

  i=$(( $i + 1 ))
done

# check if the default setup needs to be executed then run it
echo "Resulting Configuration:"
if [ -z "$(echo $execute | grep "auto")" ]
then
  echo "Command: $default"
  `$default`
else
  echo "Command: $execute"
  `$execute`
fi
echo -e "\n$(xrandr)"
Avoid X crash with xrasengan
Use this workaround to turn on connected outputs that may be in suspend mode and hence shown as disconnected, as is often the case of DisplayPort monitors:
declare -i count=2
declare -i seconds=1

while ((count)); do
    xrandr >/dev/null
    sleep $seconds
    ((count--))
done

CALISTIR=$(LIBGL_ALWAYS_SOFTWARE=1 /usr/bin/hipchat >/dev/null 2>&1)
YENIDEN_CALISTIR=$(pkill -f hipchat && LIBGL_ALWAYS_SOFTWARE=1 /usr/bin/hipchat >/dev/null 2>&1)
ps -efd |grep /usr/bin/hipchat |grep -v grep
RESULT=$?
if [ $RESULT -eq 0 ]; then
#  exit 0
  $YENIDEN_CALISTIR  
else
  $CALISTIR  
fi
#toggl_baslat=$(pkill -f TogglDesktop && cd ~/Git_Repolari/diger/toggldesktop && make run)
#ps -efd |grep TogglDesktop |grep -v grep
#RESULT=$?
#if [ $RESULT -eq 0 ]; then
#pkill -f TogglDesktop 
#else
#  ~/Git_Repolari/diger/toggldesktop/src/ui/linux/TogglDesktop/build/release/TogglDesktop >/dev/null 2>&1
#fi
=======
pkill -f hipchat && hipchat
