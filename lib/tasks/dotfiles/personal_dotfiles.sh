#!/usr/bin/env bash
#
# Personal dotfiles functions

set -Eeoux pipefail

source ./lib/utilities.sh

personal_dotfiles_symlink_unique () {
  boxecho "~/.gitignore_global ==> ~/.gitignore"
  ln -sf ~/.gitignore_global ~/.gitignore

  boxecho ".../.atom/ ==> ~/.atom/"
  /bin/ln -shF ~/.dotfiles/.atom ~/.atom
}

personal_dotfiles_symlink_normal () {
  for file in $(find . -name '.*' ! -name '.' \
    ! -name '.git' ! -name '.gitignore' ! -name '.zshrc' \
    ! -name '.oh-my-zsh' ! -name '.logs' \
    ! -path '*.atom*' ! -path '*math_dotfiles*'); do

    src="$(pwd)/$(basename $file)"
    dst="$HOME/$(basename $file)"

    boxecho "$src ==> $dst"
    ln -sf "$src" "$dst"
  done
}

personal_dotfiles_load () {
  boxecho "copy example files"
  for file in $(find . -name '.*_example'); do
    src=$file
    dst=${file/_example/}

    boxecho "$src ==> $dst"
    cp -n $src $dst || true
  done
}

personal_dotfiles () {
  echo "(unique)" >&3
  personal_dotfiles_symlink_unique
  echo "(normal)" >&3
  personal_dotfiles_symlink_normal
  echo "(load)" >&3
  personal_dotfiles_load
  echo "(done)" >&3
}

personal_dotfiles
