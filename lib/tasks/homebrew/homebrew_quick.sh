#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick () {
  boxecho "Homebrew quick installs"

  boxecho "Atom"
  echo "(Atom)" >&3
  [[ $(command -v apm) == "" ]] && echo "Installing Atom" && brew cask install atom

  boxecho "Python"
  echo "(Python)" >&3
  [[ $(command -v pip) == "" ]] && echo "Installing python v2" && brew install python@2
  [[ $(command -v pip3) == "" ]] && echo "Installing python v3" && brew install python

  boxecho "Ruby"
  echo "(Ruby)" >&3
  [[ $(command -v ruby-install) == "" ]] && echo "Installing ruby-install" && brew install ruby-install
  [[ $(command -v chruby) == "" ]] && echo "Installing chruby" && brew install chruby

  boxecho "Sublime Text"
  echo "(Sublime Text)" >&3
  [[ $(command -v subl) == "" ]] && echo "Installing sublime-text" && brew cask install sublime-text

  echo "(done)" >&3
}

homebrew_quick
