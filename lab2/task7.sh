#!/bin/bash
IFS=$'\n'
temp1=$(grep "read_bytes:"  /proc/[0-9]*/io | tr '/' ' ' | tr '[a-zA-Z] ' ' ' | tr ':' ' ' | tr '_' ' ' | sort -nk 2 |  awk '{print $1, $2}' ) 
sleep  60s 
for line in $(ps -Ao pid,command | tail -n +2 | awk '{print $1":"$2}'); do
	Pid=$(echo $line | awk -F ":" '{print $1}')
	Command=$(echo $line | awk -F ":" '{print $2}')
	if [[ -e /proc/$pid/io ]]
		then
	mem=$(grep "read_bytes:"  /proc/$Pid/io | tr '/' ' ' | tr '[a-zA-Z] ' ' ' | tr ':' ' ' | tr '_' ' ' | sort -nk 2 |  awk '{print $2}' ) 	
	echo "$Pid $Command $mem"
	fi
done > task7.tmp
for line1 in $temp1; do
		pid=$(awk '{print $1}' <<< $line1)
		#echo $line1
                initmem=$(awk '{print $2}' <<< $line1)
		#echo $initmem
	while read line2; do
		pid2=$(awk '{print $1}' <<< $line2)
		#echo $pid2
		#echo "11"
		initmem2=$(awk '{print $3}' <<< $line2)
		#echo $initmem2
		#echo "22" 
		command=$(awk '{print$2}' <<< $line2)
		if [[ $pid -eq $pid2 ]]
			then
			   memdiff=$(echo "$initmem2-$initmem" | bc)
			   echo "$pid : $memdiff $command" >> task7_1.tmp
		fi
	done < task7.tmp
done
cat task7_1.tmp | sort -nk 3 | tail -3 
