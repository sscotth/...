#!/usr/bin/env bash
#
# Node.js functions

set -Eeox pipefail
# Cant use -u:  /usr/local/opt/nvm/nvm.sh: line 2960: PROVIDED_VERSION: unbound variable

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
