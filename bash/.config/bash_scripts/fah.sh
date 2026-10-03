#!/bin/bash

FAH_PATH="/home/janlo/.local/share/fahhh/fahhh.wav"

fah() {
  if [ -f "$FAH_PATH" ]; then
    (paplay "$FAH_PATH" >/dev/null 2>&1) &
  fi
}

command_not_found_handle() {
  local cmd="$1"
  shift
  local args=("$@")

  fah
  echo "bash: command not found: $cmd bozo!" >&2

  # Ask user
  read -rsn1 -p "Search for a similar command? [y/N/r] " reply
  echo

  local selection

  case "$reply" in
  [Yy])
    selection=$(compgen -c | sort -u | fzf \
      --prompt="Select command > ")
    ;;
  [Rr])
    selection=$(compgen -c | sort -u | fzf \
      --prompt="Retry command > " \
      --query="$cmd" \
      --print-query | head -n 1)
    ;;
  *)
    return 127
    ;;
  esac

  # If user cancels
  [ -z "$selection" ] && return 127

  echo "$selection ${args[*]}"
  "$selection" "${args[@]}"
}

try_again_wrap() {
  echo "Try again?"
}
