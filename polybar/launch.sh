#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar bar1 & 
polybar bar2 &

echo "Bars launched..."
