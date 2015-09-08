#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

TARGET=~/.dotfiles/git/.gitconfig_$1

if [[ -f "$TARGET" ]]; then
  echo "Switching to '$1' config:"
  cat $TARGET
  git config include.path $TARGET
else
  echo "No '$1' config found at $TARGET."
fi
