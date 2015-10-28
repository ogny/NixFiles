#!/bin/bash
#paket=~/is/repo/tzdata-2015g-2.el6.noarch.rpm
paket="tzdata-java-2015g-2.el6.noarch.rpm"
#cmd=$(rpm -Uvh $paket)
#ptt_array=($(cat ~/is/env/off/ptt))
#alsat_array=($(cat ~/is/env/off/alsat)) 
all_array=($(cat ~/is/env/off/all))
#ipam_array=($(cat ~/is/env/off/ipam))
for i in "${all_array[@]}"
do
    scp $paket $i:~/ ; ssh -t $i sudo rpm -Uvh $paket
done    
