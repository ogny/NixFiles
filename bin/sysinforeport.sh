#!/bin/bash

#@author  yeugeniuss
#@project https://sourceforge.net/projects/sysinforeport/
#@version 1.1

#=======================================================================#
#        This script is designed to build system report                 #
#=======================================================================#

#####general info variables#######
uname_execute="uname -a"
kernel_execute="cat /proc/version"
release_info_files=( $(find /etc/*release) )
issue_execute="cat /etc/issue"
filesystem_execute="df --total -h"
memory=`cat /proc/meminfo | grep MemTotal | tr -cd [[:digit:]]`
memory_human="$(($memory/1024)) MB";

###cpu report variables######
cpuinfo="/proc/cpuinfo"
#cpuinfo=$1
cpuinfo_linesnum=`cat $cpuinfo | wc -l`

###DMI info section###
rand=$RANDOM
dmiinfo="/tmp/dmiinfoi$rand"
dmitemp="/tmp/dmitemp$rand"

path_to_find="/bin/ /sbin/ /usr/bin/ /usr/sbin/ /usr/local/bin/ /usr/local/sbin"
dmidecode_exec=`find $path_to_find -type f -name dmidecode | head -n1`
dmi=( $($dmidecode_exec -s &> $dmitemp; grep [a-z]-[a-z] $dmitemp))
rm $dmitemp

###  MAIN SECTION  #####

echo "SYSTEM REPORT:"
echo "System info (uname -a):       "`$uname_execute`
echo "Kernel info (/proc/version):  "`$kernel_execute`
echo
echo "Total Memory: $memory_human"
echo "Dirstribution release:"
echo "Welcome issue: "`$issue_execute`
echo
echo "$release_info_files"
cat $release_info_files
echo
echo "Filesystem info:"
$filesystem_execute

### CPU REPORT SECTION ####
total_number_cpu=`cat $cpuinfo | grep "physical id" | tr -d ' ' | sort -u | uniq | wc -l`
total_cores=`cat $cpuinfo | grep ^processor | wc -l`

#create array of unique cpu ID (physical id reperesents ID reference of one real CPU)
cpu_id=( $(cat $cpuinfo | grep -i "physical id[[:space:]]" | tr -d ' ' | sort -u | uniq | awk -F":" '{print $2}') )

function setCpuBlockBorders {
	local id_line_number=$1
	local line2read=$id_line_number
	local block_start_pattern="processor"
	local block_end_pattern="flags"
	
	#search cpu block start	
	while [ $line2read -ge 1 ]; do
		#echo "cpu block start line2read:$line2read"
		field_name=`awk -v var=$line2read -F":" 'NR==var{print $1}' $cpuinfo`
		#echo "fieldname: $field_name"
		if [[ $field_name == *$block_start_pattern* ]]; then
			block_start_line=$line2read
			#echo "block start=$block_start_line"
			break
		fi
		line2read=$(($line2read-1))
	done

	#search cpu block end
	line2read=$id_line_number
	while [ $line2read -lt $cpuinfo_linesnum ]; do
		#echo "cpu block end line2read:$line2read"
		field_name=`awk -v var=$line2read -F":" 'NR==var{print $1}' $cpuinfo`
		#echo "fieldname: $field_name"
		if [[ $field_name == *$block_end_pattern* ]]; then
			block_end_line=$line2read
			#echo "block end=$block_end_line"
			break
		fi
		line2read=$(($line2read+1))
	done
}

function getCpuInfo {
	setCpuBlockBorders $1
	local line2read=$block_start_line
	local model_pattern="model name"
	local cores_pattern="cpu cores"
	#parse cpu block and get current CPU information
	while [ $line2read -lt $block_end_line ]; do
		#echo "$name : $value"
		name=` awk -v var=$line2read -F": " 'NR==var{print $1}' $cpuinfo`
                value=`awk -v var=$line2read -F": " 'NR==var{print $2}' $cpuinfo`
		if [[ $name == *$model_pattern* ]]; then model=$value; fi
		if [[ $name == *$cores_pattern* ]]; then cores=$value; fi
		line2read=$(($line2read+1))			
	done
	echo "CPU model: $model"
	echo "CPU cores: $cores"
	echo
}

echo
echo "CPU report"
#count number of CPU
if [ $total_number_cpu -eq 0 ]; then
	echo "Total number of CPUs: $total_number_cpu"
	echo "Warn! Physical CPU reference was not found in /proc/cpuinfo. Probably a virtual machine?"
	echo
else
	echo "Total number of CPUs: $total_number_cpu"
	echo
fi
echo "Total number of (virtual) cores: $total_cores"
echo

#parse /proc/cpuinfo for each real CPU
for i in "${cpu_id[@]}"
do
	#echo "cpu_id:" ${cpu_id[@]}
	#echo "i="$i
	#find line number
	cpu_id_line_number=`cat $cpuinfo | grep "physical id" | grep -n -i -m 1 $i | cut -d: -f1`
	#echo "ID $i, line#: $cpu_id_line_number"
	echo "CPU ID $i"
	getCpuInfo $cpu_id_line_number
done

###DMI REPORT###
echo "DMI decoded BIOS report:" > $dmiinfo
for i in "${dmi[@]}"
do
        dmicurrent=`$dmidecode_exec -s $i`
        #echo "$i: $dmicurrent" | grep -v -i filled >> $dmiinfo
        echo "$i: $dmicurrent" >> $dmiinfo
done
cat $dmiinfo | column -t -s:
rm $dmiinfo
echo -e "\nSystem report building finished"

