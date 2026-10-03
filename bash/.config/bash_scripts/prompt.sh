#!/bin/bash

ppwd() {
  local dir
  local -i width
  test -n "$TS1" || return
  dir="$(dirs +0)"
  let width=${#dir}-18
  test ${#dir} -le 18 || dir="...${dir#$(printf "%.*s" $width "$dir")}"
  if test ${#TS1} -gt 17; then
    printf "$TS1" "$USER" "$HOST" "$dir" "$HOST"
  else
    printf "$TS1" "$USER" "$HOST" "$dir"
  fi
}

_update_ps1() {
  PS1="\[$(ppwd)\]\u@\h:\W:\A> "
}
PROMPT_COMMAND=_update_ps1

if [ -x "$(command -v fastfetch)" ]; then
  if [[ $- == *i* ]]; then
    fastfetch -l none -s title:os:kernel:uptime:break:cpu:gpu:break:disk:break:memory:swap
    echo
  fi
fi
