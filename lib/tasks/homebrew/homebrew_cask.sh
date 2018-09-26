#!/usr/bin/env bash

homebrew_cask () {
  # echo "Cleanup Homebrew taps"
  # if [[ $(brew tap | grep -v core) ]]; then
  #   echo "Removing taps..."
  #   brew untap $(brew tap | grep -v core)
  # fi

  echo "Homebrew Cask"
  # brew uninstall --force brew-cask
  brew cask

  echo "Homebrew Cask Doctor"
  brew cask doctor

  echo "Updating Homebrew"
  brew update
}

homebrew_cask
