#!/bin/bash

pcd() {
  local pid dir
  pid=$(ps -eo pid,user,comm,args --sort=-pcpu | fzf --header-lines=1 --prompt='process> ' | awk '{print $1}') || return
  [ -z "$pid" ] && return

  dir=$({
    readlink -f "/proc/$pid/cwd"
    readlink -f "/proc/$pid/exe"
    readlink -f "/proc/$pid/fd/"* 2>/dev/null
  } 2>/dev/null |
    while read -r p; do [ -d "$p" ] && echo "$p" || dirname "$p"; done |
    sort -u | fzf --prompt='folder> ') || return

  [ -n "$dir" ] && cd "$dir"
}
