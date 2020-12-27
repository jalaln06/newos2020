#!/bin/bash

ps -eo pid,lstart | tail -1 | awk '{print $1}' >task3ans     
