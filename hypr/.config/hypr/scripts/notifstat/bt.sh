#!/bin/bash

DEV_ADDR=$(bluetoothctl info | awk '/Device/ {print $2; exit}')
DEV_NAME=$(bluetoothctl info | awk '/Name:/ {print $2; exit}')
DEV_PREC=$(bluetoothctl info | awk -F '[()]' '/Battery Percentage:/ {out=$2; exit} END { printf "Battery: %d%%", out}')

TITLE="Bluetooth"
DESC="$DEV_ADDR\n$DEV_NAME\n$DEV_PREC"
if test -z "$DEV_NAME"; then
    TITLE="No bluetooth devices are now connected!"
    DESC=""
fi 
notify-send "$TITLE" "$DESC"
