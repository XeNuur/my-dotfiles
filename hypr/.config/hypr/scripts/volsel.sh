#!/bin/bash
pkill wofi
pactl set-sink-volume @DEFAULT_SINK@ $(seq 0 1 100 | wofi -S dmenu -p "Volume")%
