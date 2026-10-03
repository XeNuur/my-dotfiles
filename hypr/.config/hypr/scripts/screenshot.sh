#!/usr/bin/env bash
PIC_FOLDER="$(xdg-user-dir PICTURES)"
SCREENSHOT_FOLDER="$PIC_FOLDER/Screenshots"
mkdir -p $SCREENSHOT_FOLDER

PIC_NAME="$(date +'screenshot_%Y-%m-%d-%H%M%S.png')"
PICTURE_PATH="$SCREENSHOT_FOLDER/$PIC_NAME"

grim - > $PICTURE_PATH
