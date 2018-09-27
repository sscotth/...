#!/usr/bin/env bash
#
# Node.js functions

set -Eeoux pipefail

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

install_node_version_manager () {
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

install_node_version_manager
