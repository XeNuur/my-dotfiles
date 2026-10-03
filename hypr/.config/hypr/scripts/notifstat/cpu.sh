#!/bin/bash
CPU_USE=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.2f", usage}')
notify-send "Cpu useage" "$CPU_USE%" -h "int:value:$CPU_USE"
