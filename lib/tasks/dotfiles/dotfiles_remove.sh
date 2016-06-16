#!/usr/bin/env bash
#
# General dotfiles functions

dotfiles_remove () {
  echo "removing dotfiles"

  find ~ -type l -d 1 -delete
}

dotfiles_remove
