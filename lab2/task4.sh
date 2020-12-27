#!/bin/bash
for line in $( ps -Ao pid | tail -n +2 ); do
	PPid=$( grep -s "PPid" /proc/$line/status | tr ':' ' '  | awk '{ print $2 }' )
	sum_exec_runtime=$( grep -s "se.sum_exec_runtime" /proc/$line/sched | tr ':' ' ' | awk '{ print $2 }' )
	nr_switches=$( grep -s "nr_switches" /proc/$line/sched | tr ':' ' ' | awk '{ print $2 }' )
	if [[ -n $nr_switches ]]; then 
	ART=$(echo "scale=6; $sum_exec_runtime/$nr_switches" | bc | awk '{printf "%f", $0}' )
	echo "ProcessID=$line : Parent_ProcessID=$PPid : Average_Running_Time=$ART"
	fi
done | sort -n -t "=" -k3  > task4ans

