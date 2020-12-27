#!/bin/bash
rm truba
mkfifo truba

./task5han.sh&
./task5gen.sh

rm truba