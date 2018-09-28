#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick_nvm () {
  boxecho "Homebrew quick installs"

  boxecho "remove nvm, npm, and installed nodes"
  echo "(deleting...)" >&3
  rm -rf ~/.nvm ~/.npm
  mkdir ~/.nvm ~/.npm

  boxecho "Install nvm"
  echo "(brew install nvm...)" >&3
  brew reinstall nvm

  boxecho "Load nvm"
  echo "(Load nvm)" >&3
  load_nvm

  nvm --version
  echo "($(nvm --version))" >&3
}

homebrew_quick_nvm
