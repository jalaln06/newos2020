#!/bin/bash
IFS=$'\n'
Section_PPid=0
ArtSum="0"
ArtAmount="0"
ArtSectionAverage=0
ArtSectionEnd=0
temp=$(cat task4ans | tr ':' ' ' | tr '=' ' ')
for line in $temp ;
do	
	PPid=$(echo "$line" | awk '{ print $4}' )
	art=$(echo "$line" | awk '{ print $6 }')
	if [[ ! $PPid  -eq $Section_PPid ]];then
		if [[ $ArtAmount -eq 0 ]];then
			ArtSectionAverage=0
		else
		ArtSectionAverage=$(echo "scale=7; $ArtSum/$ArtAmount" | bc | awk '{printf "%f", $0}' )
		fi
		echo "Average_Sleeping_Children_of_ParentID=$Section_PPid is $ArtSectionAverage"
		ArtSum="0"
		ArtAmount="0"
		ArtSectionEnd=$ArtSectionAverage
		ArtSectionAverage=0
		Section_PPid=$PPid
	fi
	ArtSum=$( echo "scale=7; $ArtSum+$art" | bc  )
	ArtAmount=$(( $ArtAmount+1 ))
	Pid=$( echo "$line" | awk '{ print $2 }' )
	echo "ProcessID=$Pid : Parent_ProcessID=$PPid : Average_Running_Time=$art"
done > task5ans
ArtSectionEnd=$(echo "scale=7; $ArtSum/$ArtAmount" | bc | awk '{printf "%f", $0}' )
echo "Average_Sleeping_Children_of_ParentID=$Section_PPid is $ArtSectionEnd" > task5ans
