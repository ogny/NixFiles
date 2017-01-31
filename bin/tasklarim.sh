#!/bin/bash
geeknote find --notebooks diger --search |cut -d\  -f 8-    > Downloads/tasklarim/diger.txt
geeknote find --notebooks kisisel --search |cut -d\  -f 8-  > Downloads/tasklarim/kisisel.txt
geeknote find --notebooks gelistir --search |cut -d\  -f 8- > Downloads/tasklarim/gelistir.txt
geeknote find --notebooks is --search |cut -d\  -f 8-       > Downloads/tasklarim/is.txt
