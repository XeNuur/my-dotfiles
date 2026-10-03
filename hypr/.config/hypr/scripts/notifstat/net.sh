#!/bin/bash

DEVNAME=$(ip route | grep default | awk '{print $5}')
IP_ADDRESS=$(ip route | grep default | awk '{print $9}')
DESC=""

TITLE="Active: $DEVNAME $SSID_NAME"
if test -z "$DEVNAME"; then
    TITLE="Disconnected..."
else
    SSID_NAME=$(iwgetid -r)
    DESC=$"$IP_ADDRESS\n$SSID_NAME"
fi
notify-send "$TITLE" "$DESC"

