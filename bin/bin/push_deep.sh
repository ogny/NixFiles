#!/bin/bash

DIRS=`find . -mindepth 1 -maxdepth 1 -type d | egrep -v "(^./(ca)$)"`

for d in $DIRS
	do cd $d
	p=`pwd`
	echo $p
	DIRS2=`find $p -mindepth 1 -maxdepth 1 -type d | egrep -v "(^./(ca)$)"`
	for d2 in $DIRS2
		do cd $d2
		pwd
		git pull
	done
	#git pull
	cd ..
done
