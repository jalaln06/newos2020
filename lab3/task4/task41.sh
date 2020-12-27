#!/bin/bash
./task4.sh&Pid0=$!
./task4.sh&Pid2=$!
renice -n 10 -p $Pid0

at now + 1 minute <<< "kill ${Pid2}"
top
at now +2 minute <<< "killall task4.sh"