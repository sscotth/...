#!/usr/bin/env bash
#
# Node.js functions

install_node_lts_packages () {
  . ~/.nvm/nvm.sh

  nvm use --lts

  echo "(ionic)" >&3
  npm install -g ionic
  npm install -g node-inspector

  echo "(done)" >&3
}

install_node_lts_packages
