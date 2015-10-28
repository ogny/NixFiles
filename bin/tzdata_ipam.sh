#!/bin/bash
#paket=~/is/repo/tzdata-2015g-2.el6.noarch.rpm
#ptt_array=($(cat ~/is/env/off/ptt))
#alsat_array=($(cat ~/is/env/off/alsat)) 
#all_array=($(cat ~/is/env/off/all))
ipam_array=($(cat ~/is/env/on/ipam))
for i in "${ipam_array[@]}"
do
ssh -t $i yum update tzdata-java
done
