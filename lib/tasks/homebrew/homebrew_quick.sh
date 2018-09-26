#!/usr/bin/env bash

source ./lib/utilities.sh

homebrew_quick () {
  echo "Homebrew quick installs"

  echo "Atom"
  [[ $(command -v apm) == "" ]] && echo "Installing Atom" && brew cask install atom

  echo "Python"
  [[ $(command -v pip) == "" ]] && echo "Installing python v2" && brew install python@2
  [[ $(command -v pip3) == "" ]] && echo "Installing python v3" && brew install python

  echo "Ruby"
  [[ $(command -v ruby-install) == "" ]] && echo "Installing ruby-install" && brew install ruby-install
  [[ $(command -v chruby) == "" ]] && echo "Installing chruby" && brew install chruby

  echo "Sublime Text"
  [[ $(command -v subl) == "" ]] && echo "Installing sublime-text" && brew cask install sublime-text
}

homebrew_quick
