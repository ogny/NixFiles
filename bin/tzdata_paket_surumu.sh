#!/bin/bash
all_array=($(cat ~/is/env/on/ipam))
for i in "${all_array[@]}"
do
    ssh -t $i "rpm -qa |grep tzdata"
done
