#!/usr/bin/env bash
#
# Personal dotfiles functions

personal_dotfiles_load () {
  echo "copy example files"
  for file in $(find . -name '.*_example'); do
    src=$file
    dst=${file/_example/}

    echo "$src ==> $dst"
    cp -n $src $dst
  done

  my_sleep "${@}"
}

personal_dotfiles_symlink () {
  echo "symlinking personal dotfiles"

  personal_dotfiles_symlink_unique
  personal_dotfiles_symlink_normal

  my_sleep "${@}"
}

### LOCAL ###

personal_dotfiles_symlink_unique () {
  echo "~/.gitignore_global ==> ~/.gitignore"
  ln -sf ~/.gitignore_global ~/.gitignore

  echo "~/.atom/ ==> ~/.atom/"
  ln -sf ~/.dotfiles/.atom ~/.atom
}

personal_dotfiles_symlink_normal () {
  for file in $(find . -name '.*' ! -name '.' \
    ! -name '.git' ! -name '.gitignore' ! -name '.zshrc' \
    ! -path '*.atom*' ! -path '*math_dotfiles*'); do

    src="$(pwd)/$(basename $file)"
    dst="$HOME/$(basename $file)"

    echo "$src ==> $dst"
    ln -sf "$src" "$dst"
  done
}
