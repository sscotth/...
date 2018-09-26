#!/usr/bin/env bash

sublime_text_plugins () {

  echo "Remove old sublime-text settings"
  rm -rf /Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

  echo "Symlink sublime-text settings"
  ln -fs ~/.dotfiles/SublimeText/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  ln -fs ~/.dotfiles/SublimeText/highlighter.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

  echo "Install Package Control"
  curl https://packagecontrol.io/Package%20Control.sublime-package > ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package

  echo "symlink requried packages"
  ln -sf ~/.dotfiles/SublimeText/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

}

sublime_text_plugins
