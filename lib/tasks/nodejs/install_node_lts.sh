#!/usr/bin/env bash
#
# Node.js functions

export NVM_SYMLINK_CURRENT=true

install_node_lts () {
  local version=v4
  . ~/.nvm/nvm.sh

  nvm install $version

  echo "Setup alias"
  nvm alias lts $version

  echo "Update npm"
  npm install -g npm
}

install_node_lts
