#!/bin/bash

MEM_ALL=$(awk '/MemTotal/ {$2=int($2/1024); print $2}' /proc/meminfo)
MEM_AVAL=$(awk -v mem_all="$MEM_ALL" '/MemAvailable/ {$2=mem_all-int($2/1024); print $2}' /proc/meminfo)
MEM_PREC=$(awk -v mem_all="$MEM_ALL" -v mem_aval="$MEM_AVAL" 'BEGIN {printf "%d", (mem_aval/mem_all)*100}')

FORMAT=$(echo -e "${MEM_AVAL} Mb of ${MEM_ALL} Mb")
notify-send "Memory useage" "$FORMAT" -h "int:value:$MEM_PREC"

