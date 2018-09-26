# #!/usr/bin/env bash

homebrew_cask () {
  echo "Remove Homebrew taps"
  brew untap $(brew tap | grep -v core)

  echo "Homebrew Cask"
  brew uninstall --force brew-cask
  brew cask

  echo "Homebrew Cask Doctor"
  brew cask doctor

  echo "Updating Homebrew"
  brew update
}

homebrew_cask
