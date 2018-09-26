#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

install_node_stable () {
  load_nvm

  nvm install node

  echo "Setup alias"
  nvm alias default node
}

install_node_stable
