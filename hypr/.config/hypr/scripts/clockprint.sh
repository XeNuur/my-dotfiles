#!/usr/bin/env bash
TIME_H=$(date +%H)
TIME_M=$(date +%M)
TIME_S=$(date +%s)

TIME_SEP=$( (( TIME_S % 2 == 0 )) && echo ":" || echo " " )
echo "$TIME_H$TIME_SEP$TIME_M"

