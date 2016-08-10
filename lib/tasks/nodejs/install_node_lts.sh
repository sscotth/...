#!/usr/bin/env bash
#
# Node.js functions

export NVM_SYMLINK_CURRENT=true

install_node_lts () {
  . ~/.nvm/nvm.sh

  nvm install --lts

  echo "Update npm"
  npm install -g npm
}

install_node_lts
