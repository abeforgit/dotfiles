#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')
polybar bar1 & 
polybar bar2 &

echo "Bars launched..."
