#!/bin/bash


echo "Total Count:" > task1ans
sudo ps -U root | wc -l >> task1ans
ps -fU root | tail -n +2 | awk '{print $2 ":" $8}' >> task1ans

