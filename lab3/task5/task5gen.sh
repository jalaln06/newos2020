#!/bin/bash
while true; do
    read LINE
    case $LINE in
        QUIT)
            echo "$LINE" > truba
            exit 0
        ;;
        "+")
            echo "$LINE" > truba
        ;;
        "*")
            echo "$LINE" > truba
        ;;
        [0-9]*)
            echo "$LINE" > truba
        ;;
        *)
            echo "AVARIYA" > truba
            exit 0
        ;;
    esac
done