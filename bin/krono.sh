#!/bin/bash
# Kronometre
stf=$(date +%s.%N);for ((;;));do ctf=$( date +%s.%N ); \
    echo -en "\r$(date -u -d "0 $ctf sec - $stf sec" "+%H:%M:%S.%N")";done
