#!/bin/bash

DIRS=`find . -mindepth 1 -maxdepth 1 -type d | egrep -v "(^./samba$)"`

for d in $DIRS
	do cd $d
	pwd
	git pull
	cd ..
done
