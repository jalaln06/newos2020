#!/bin/bash

filename=$1

if [[ $# != 1 ]]; then
    echo "Enter filename"
    exit 1
fi

if [[ ! -f $(pwd)/$filename ]]; then
    echo "FILENAME NOT EXISTENT"
    exit 2
fi

if [[ ! -e /home/user/.trash ]]; then
    mkdir /home/user/.trash 
fi

if [[ ! -e uuid ]]; then
    touch uuid
    echo "10" > uuid
fi
temp=$(cat uuid)

ln "$filename" /home/user/.trash/$temp
echo "$(pwd)/ : $filename : $temp " >> /home/user/.trashlog
temp=$(($temp+1))
echo "$temp" > uuid
cat uuid
rm "$filename"