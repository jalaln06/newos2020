#!/bin/bash
ps -ef | grep "[0-9] /sbin/" | awk '{ print $8}'  > task2ans 
