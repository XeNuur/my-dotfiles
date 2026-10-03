#!/bin/bash

DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')
SINK_PROP="$(pactl list sinks | grep -A 30 "Name: $DEFAULT_SINK")"

DESCRIP=$(printf "%s\n" "$SINK_PROP" | awk -F 'Description: ' 'NF>1 {print $2; exit}')
AUDIO_VOL=$(printf "%s\n" "$SINK_PROP" | awk '/Volume:/ {print $5; exit}')

TITLE="Current audio"
if test -z "$DEFAULT_SINK"; then
    TITLE="No audio output available..."
fi 
notify-send "$TITLE" "$DESCRIP $AUDIO_VOL"
