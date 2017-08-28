#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

install_node_lts () {
  load_nvm

  nvm install --lts

  echo "Update npm"
  npm install -g npm
}

install_node_lts
