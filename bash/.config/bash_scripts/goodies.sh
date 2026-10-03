#!/bin/bash

rget() {
  $(cat $HOME/.bash_history | fzf)
}

fzfcdi() {
  local args=("$@")
  fzf --preview='tree -C -d {} | head -n 50' --preview-window=70%,border-double,top $args
}

cdi() {
  if [ -n "$1" ]; then
    if [ -d "$1" ]; then
      cd "$1"
    else
      echo "Directory does not exist"
      return 1
    fi
  fi

  while true; do
    nextpath="$({
      find . -maxdepth 1 -mindepth 1 -type d -printf '%P\n'
      echo "$PWD/.."
    } | fzfcdi)"
    if [ -z "$nextpath" ]; then
      break
    fi
    cd -- "$nextpath"
  done
  echo "Current directory: $PWD"
}

shopt -s autocd
