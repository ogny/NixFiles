#!/bin/bash
all_array=($(cat ~/ipam_sunucular))
for i in "${all_array[@]}"
do
    knife node show $i |grep 'Run List:'
done
