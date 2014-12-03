#!/bin/bash
while true; do
    echo -en "\e[1;37m"
    read -p " > " string
    echo -en "\e[1;35m"
    trans "$string" 
done
