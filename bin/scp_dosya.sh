#!/bin/bash

all_array=($(cat ~/ipam-fatih))
  for i in "${all_array[@]}"; do
    scp /home/orkung/Linux_x64_RWC2_v15.11.00.13.tar.gz $i:~/
  done

  
