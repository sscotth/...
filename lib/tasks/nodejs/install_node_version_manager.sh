#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

echo $CONCURRENT_TASK_NAME

install_node_version_manager () {
  # remove nvm, npm, and installed nodes
  rm -rf ~/.nvm ~/.npm

  brew update
  brew install nvm

  load_nvm

  nvm --version
}

install_node_version_manager
