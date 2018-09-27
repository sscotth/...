#!/usr/bin/env bash

set -Eeoux pipefail

homebrew_cask () {

  # echo "Cleanup Homebrew taps"
  # if [[ $(brew tap | grep -v core) ]]; then
  #   echo "Removing taps..."
  #   brew untap $(brew tap | grep -v core)
  # fi

  echo "Homebrew Cask"
  echo "(Cask install...)" >&3
  # brew uninstall --force brew-cask
  brew cask

  echo "Updating Homebrew"
  echo "(Homebrew update)" >&3
  brew update

  echo "Homebrew Cask Doctor"
  echo "(Cask doctor)" >&3
  brew cask doctor

  echo "(done)" >&3
}

homebrew_cask
