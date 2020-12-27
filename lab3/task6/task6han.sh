#!/bin/bash

res=1
switch="+"
death () {
    echo "DEATH"
    exit 0
}
toggleplus () {
    switch="+"
}
togglemul () {
    switch="*"
}

trap 'toggleplus' USR1
trap 'togglemul' USR2
trap 'death' SIGTERM

while true; do
        case $switch in
            "+")
                let res=$res+2
            ;;
            "*")
                res=$( echo "$res * 2" | bc )
            ;;
        esac
        echo "$res"
        sleep 1s
done
            
            
