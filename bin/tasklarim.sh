#!/bin/bash
geeknote find --notebooks genel --search |cut -d\  -f 8-  > ~/Downloads/tasklarim/genel.txt
geeknote find --notebooks gelistir --search |cut -d\  -f 8- > ~/Downloads/tasklarim/gelistir.txt
geeknote find --notebooks is --search |cut -d\  -f 8-       > ~/Downloads/tasklarim/is.txt
geeknote find --notebooks is_task --search |cut -d\  -f 8-  > ~/Downloads/tasklarim/is_task.txt
