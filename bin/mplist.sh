#!/bin/bash
cd ~/Copy/multimedia/muzik/classic
#for i in $(ls); do
for i in $(find . -iname "*.mp3"); do 
	mplayer -slave -input file=/tmp/mplayer-control -lavdopts threads=2 $i
done
