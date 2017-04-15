#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

install_node_lts_packages () {
  load_nvm

  nvm use --lts

  # echo "(ionic)" >&3
  # npm install -g ionic
  # echo "(node-gyp)" >&3
  # npm install -g node-gyp

  echo "(done)" >&3
}

install_node_lts_packages
