#!/usr/bin/env bash
#
# General dotfiles functions

dotfiles_remove () {
  echo "Delete symlinks in the home directory"

  find ~ -type l -d 1 -delete
}

dotfiles_remove
