#!/bin/bash
mp3_dizini='/home/orkung/Copy/multimedia/muzik/indie/mp3s'
cd $mp3_dizini
for i in $(ls); do
	ffplay -nodisp -t 200 -autoexit $i 
done
