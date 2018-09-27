#!/usr/bin/env bash
#
# General dotfiles functions

set -Eeoux pipefail

source ./lib/utilities.sh

dotfiles_remove () {
  boxecho "Find symlinks in the home directory"
  find ~ -type l -maxdepth 1
  boxecho "Delete symlinks in the home directory"
  find ~ -type l -maxdepth 1 -delete
  echo "(done)" >&3
}

dotfiles_remove
