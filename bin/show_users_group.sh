#!/bin/bash

# get group if no argument provided
if [ $# == 0 ]; then
    echo -n "group name or number> "
    read group
else
    group=$1
fi

# regular expression for numbers
re='^[0-9]+$'

# get info from the /etc/group file
# =================================
# check if response is a string
if ! [[ $group =~ $re ]] ; then		# group name
    grp=`grep "^$group:" /etc/group`	# make sure it exists
    if [ $? != 0 ]; then                # not found
        echo No such group: $group
        exit 1
    else                                # found group number and members in /etc/group
        gnumber=`echo "$grp" | awk -F: '{print $3}'`
        members=`echo "$grp" | awk -F: '{print $NF}'`
        if [ "$members" != "" ]; then
            echo $members | tr "," "\n"	# list members in /etc/group
        fi
    fi
else    # response is numeric
    gnumber=$group
    members=`grep ":x:$group:" /etc/group | awk -F: '{print $NF}'`
    if [ $? == 0 ]; then
        if [ "$members" != "" ]; then
            echo $members | tr "," "\n"
        fi
    fi
fi

# get info from the /etc/passwd file
# ==================================
while read line
do
    gid=`echo $line | awk -F: '{print $4}'`
    if [ $gid == $gnumber ]; then
        echo $line | awk -F: '{print $1}'
    fi
done < /etc/passwd