#!/bin/bash

TIME=$(date +"%T")
DATE=$(date +"%F\n%A")
notify-send "$TIME" "$DATE"
