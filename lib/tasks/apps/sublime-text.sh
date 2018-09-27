#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

sublime_text_plugins () {
  boxecho "Remove old sublime-text settings"
  rm -rf /Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

  boxecho "Symlink sublime-text settings"
  ln -fs ~/.dotfiles/SublimeText/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  ln -fs ~/.dotfiles/SublimeText/highlighter.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

  boxecho "Install Package Control"
  curl https://packagecontrol.io/Package%20Control.sublime-package > ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package

  boxecho "symlink requried packages"
  ln -sf ~/.dotfiles/SublimeText/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

  echo "(done)" >&3
}

sublime_text_plugins
