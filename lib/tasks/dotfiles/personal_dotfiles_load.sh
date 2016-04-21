#!/usr/bin/env bash
#
# Personal dotfiles functions

personal_dotfiles_load () {
  echo "copy example files"
  for file in $(find . -name '.*_example'); do
    src=$file
    dst=${file/_example/}

    echo "$src ==> $dst"
    cp -n $src $dst || true
  done
}

personal_dotfiles_load
