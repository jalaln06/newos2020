#!/bin/bash

res=1
switch="+"
tail -f truba |
while true; do
        read LINE
        case $LINE in
            "+")
                switch="+"
                echo "Sum"
            ;;
            "*")
                switch="*"
            ;;
            "QUIT")
                echo "EXIT"
                exit 0
            ;;
            [0-9]*)
                if [[ "$switch" == "+" ]]; then
                    res=$(($res+$LINE))
                else
                    res=$( echo "$res * $LINE" | bc )
                fi
                echo "$res"
            ;;
            "AVARIYA")
                echo "VSE POLOMALOS"
                exit 1
            ;;
            *)
            :
            ;;
        esac
done
            
            
