#!/bin/bash
for i in $(ls); do
	ffmpeg -i $i -q:a 0 -map a $i.mp3
done
