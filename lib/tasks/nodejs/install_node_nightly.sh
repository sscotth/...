#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

install_node_nightly () {
  NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly nvm install node

  load_nvm

  echo "Setup alias"
  nvm alias nightly node

  echo "Update npm"
  npm install -g npm
}

install_node_nightly
