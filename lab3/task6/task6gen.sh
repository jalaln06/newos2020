#!/bin/bash

./task6han.sh&Pid=$!
while true; do
    read LINE
    case $LINE in
        "+")
            kill -USR1 $Pid
        ;;
        "*")
            kill -USR2 $Pid
        ;;
        "TERM")
            kill -SIGTERM $Pid
            exit 0
        ;;
        *)
         :
        ;;
    esac
done