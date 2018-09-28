#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick_subl () {
  boxecho "Homebrew quick installs"

  boxecho "Sublime Text"

  ! command_exists subl && echo "Installing sublime-text" && brew cask install sublime-text

  echo "($(subl --version))" >&3
}

homebrew_quick_subl
