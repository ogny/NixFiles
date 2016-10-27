#!/bin/bash

all_array=($(cat ~/is/env/off/alsat))
  for i in "${all_array[@]}"; do
    scp ~/Downloads/tzdata-2016g-2.el6.noarch.rpm root@$i:~/ 
  done

  
