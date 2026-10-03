#!/bin/bash

FZCD_PATH=~/.local/share/fzfcd_path.history
FZCD_MAX=500
FZCD_FZF=""

fzfcdzen() {
  local args=("$@")
  fzf --preview='tree -C {} | head -n 50' --preview-window=70%,border-double,top $args
}

cdmark() {
  selpath="$1"
  if [ -z "$selpath" ]; then
    selpath="$PWD"
  fi
  truepath=$(realpath "$selpath")

  echo "$truepath" >>"$FZCD_PATH"
  tail -n $FZCD_MAX "$FZCD_PATH" | awk '!seen[$0]++' >"$FZCD_PATH.tmp"
  mv "$FZCD_PATH.tmp" "$FZCD_PATH"
}

cdzen() {
  selpath=$(cat $FZCD_PATH | fzfcdzen --tac)
  if [ -n $selpath ]; then
    cd $selpath
  fi
}

cdfzf() {
  path="$1"
  if [ -z "$path" ]; then
    path="$PWD"
  fi
  selpath=$(find "$path" -type d 2>&1 | fzfcdzen)
  if [ -n "$selpath" ]; then
    cd "$selpath"
    cdmark $selpath
  fi
}

cdzedit() {
  DEF_EDITOR="$EDITOR"
  if [ -z "$EDITOR" ]; then
    echo "EDITOR variable is not set. "
    return 1
  fi
  $DEF_EDITOR $FZCD_PATH
}

ezen() {
  DEF_EDITOR="$EDITOR"
  if [ -n "$1" ]; then
    DEF_EDITOR="$1"
  fi

  if [ -z "$EDITOR" ]; then
    echo "EDITOR variable is not set. "
    return 1
  fi
  cdzen
  $DEF_EDITOR
}
