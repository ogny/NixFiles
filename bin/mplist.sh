#!/bin/bash
cd ~/Copy/multimedia/muzik/classic
sarkilar=`ls -R |find . -iname "*.mp3"`
	mplayer -slave -quiet -input file=/tmp/mplayer-control -lavdopts threads=2 $sarkilar  >/dev/null 2>&1
