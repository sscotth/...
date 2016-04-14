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
  /bin/ln -shF ~/.dotfiles/.atom ~/.atom

  echo "~/.dotfiles/SublimeText/Preferences.sublime-settings ==> ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings"
  ln -fs ~/.dotfiles/SublimeText/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings

  echo "~/.dotfiles/SublimeText/Preferences.sublime-settings ==> ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings"
  ln -sf ~/.dotfiles/SublimeText/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
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
