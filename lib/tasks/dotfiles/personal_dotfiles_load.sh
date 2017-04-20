#!/usr/bin/env bash
#
# Personal dotfiles functions

source ./lib/utilities.sh

personal_dotfiles_load () {
  echo "copy example files"
  for file in $(find . -name '.*_example'); do
    src=$file
    dst=${file/_example/}

    echo "$src ==> $dst"
    cp -n $src $dst || true
  done

  cached_psudo ~/.osx_supplement
}

personal_dotfiles_load
