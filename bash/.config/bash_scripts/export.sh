#!/bin/bash

export OCL_ICD_VENDORS=rusticl.icd
export RUSTICL_ENABLE=radeonsi
export MANPAGER='nvim +Man!'
export PLAN9=/home/janlo/Dokumenty/Coding/plan9

# add binaries to PATH if they aren't added yet
# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
*:"$HOME/.local/share/../bin":*)
  ;;
*)
  # Prepending path in case a system-installed binary needs to be overridden
  export PATH="$HOME/.local/share/../bin:$PATH"
  ;;
esac

export PATH="$PATH:/home/janlo/.opencode/bin"
export PATH="$PATH:/home/janlo/.local/bin"
export PATH="$PATH:$HOME/.local/bin/flutter/bin"
export PATH="$PATH:$PLAN9/bin"
export PATH="$PATH:/sbin"

if command -v pyenv >/dev/null 2>&1; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init - bash)"
fi
