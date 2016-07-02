#!/usr/bin/env bash
#
# Node.js functions

export NVM_SYMLINK_CURRENT=true

install_node_nightly () {
  . ~/.nvm/nvm.sh

  NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly nvm install node

  echo "Setup alias"
  nvm alias nightly node

  echo "Update npm"
  npm install -g npm
}

install_node_nightly
