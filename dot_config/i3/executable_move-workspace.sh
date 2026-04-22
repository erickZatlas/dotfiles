#!/bin/bash
pkill xcompmgr 2>/dev/null
pkill picom 2>/dev/null
sleep 0.3
i3-msg "move workspace to output next"
sleep 0.5
xcompmgr -c -C -r 6 -o 0.4 -l -5 -t -5 &
