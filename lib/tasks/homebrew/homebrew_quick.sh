#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick () {
  boxecho "Homebrew quick installs"

  boxecho "Atom"
  echo "(Atom)" >&3
  ! command_exists apm && echo "Installing Atom" && brew cask install atom

  boxecho "Python"
  echo "(Python)" >&3
  ! command_exists pip && echo "Installing python v2" && brew install python@2
  ! command_exists pip3 && echo "Installing python v3" && brew install python

  boxecho "Ruby"
  echo "(Ruby)" >&3
  ! command_exists ruby-install && echo "Installing ruby-install" && brew install ruby-install
  ! command_exists chruby && echo "Installing chruby" && brew install chruby

  boxecho "Sublime Text"
  echo "(Sublime Text)" >&3
  ! command_exists subl && echo "Installing sublime-text" && brew cask install sublime-text

  echo "(done)" >&3
}

homebrew_quick
