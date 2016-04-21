#!/usr/bin/env bash
#
# Node.js functions

export NVM_SYMLINK_CURRENT=true

install_node_stable () {
  . ~/.nvm/nvm.sh

  nvm install node

  echo "Setup alias"
  nvm alias default node

  echo "Update npm"
  npm install -g npm
}

install_node_stable
