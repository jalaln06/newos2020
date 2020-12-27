#!/bin/bash

today=$(date +'%Y_%m_%d_%H.%M.%S')
mkdir /home/user/test &&  echo "catalog test was created succesfully" >> /home/user/report && touch /home/user/test/$today
ping www.net_nikogo.ru || echo "$today error" >> /home/user/report 