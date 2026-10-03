#!/bin/bash

DESC=$"$(playerctl metadata title)\n\n$(playerctl metadata artist)"
STATUS=$?

TITLE="Current playing"
case "$(playerctl status)" in
    "Paused") ICON="⏸ ";;
    "Playing") ICON=" ";;
    *) ICON=" ";;
esac

if test "${STATUS}" -ne 0; then
    TITLE="Nothing is being played at the moment..."
fi

notify-send "$ICON $TITLE" "$DESC"
