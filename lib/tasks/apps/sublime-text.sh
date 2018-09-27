#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

sublime_text_plugins () {
  boxecho "Removing old sublime-text settings..."
  echo "(Removing old sublime-text settings...)" >&3
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

  mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

  boxecho "Symlink sublime-text settings..."
  echo "(Symlink sublime-text settings...)" >&3
  ln -fs ~/.dotfiles/SublimeText/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  ln -fs ~/.dotfiles/SublimeText/highlighter.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/highlighter.sublime-settings

  boxecho "Installing package control..."
  echo "(Installing package control...)" >&3
  curl https://packagecontrol.io/Package%20Control.sublime-package > ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package

  boxecho "Symlinking required packages..."
  echo "(Symlinking required packages...)" >&3
  ln -fs ~/.dotfiles/SublimeText/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings

  echo "(done)" >&3
}

sublime_text_plugins
