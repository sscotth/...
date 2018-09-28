#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick_atom () {
  boxecho "Homebrew quick installs"

  boxecho "Atom"
  ! command_exists apm && echo "Installing Atom" && brew cask install atom
  echo "($(atom --version | grep Atom | sed 's/^.*://' | awk '{$1=$1};1'))" >&3
}

homebrew_quick_atom
