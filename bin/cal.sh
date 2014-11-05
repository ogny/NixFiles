#!/bin/bash
for i in $(ls); do
	ffplay -nodisp -t 150 -autoexit $i 
done
