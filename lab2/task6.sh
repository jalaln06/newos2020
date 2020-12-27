#!/bin/bash
echo "FROM /Proc"
grep "VmRSS" /proc/[0-9]*/status | tr '/' ' ' | tr '[a-zA-Z] ' ' ' | tr ':' ' ' | sort -nk 2 | tail -1 | awk '{print $1 , $2}'
echo "From top"
top -b -o +%MEM | head -n 8 | tail -n 1 | awk '{print $1, $6}'  
