#!/usr/bin/env bash
#
# General dotfiles functions

dotfiles_remove () {
  echo "Find symlinks in the home directory"
  find ~ -type l -maxdepth 1
  echo "Delete symlinks in the home directory"
  find ~ -type l -maxdepth 1 -delete
}

dotfiles_remove
