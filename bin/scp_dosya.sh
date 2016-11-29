#!/bin/bash

all_array=($(cat ~/fatih_etlik))
  for i in "${all_array[@]}"; do
    sshpass -f ~/is/parolalar/dpic_fatih/root scp /home/orkung/files/supervisor-3.3.0.tar.gz $i:~/
  done

  
