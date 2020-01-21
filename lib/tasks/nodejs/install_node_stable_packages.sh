#!/usr/bin/env bash
#
# Node.js functions

set -Eeoux pipefail

source ./lib/utilities.sh

install_node_stable_packages () {
  load_nvm

  nvm use node

  echo "(expo-cli)" >&3
  npm install -g expo-cli

  echo "(npm-check-updates)" >&3
  npm install -g npm-check-updates

  echo "(pure-prompt)" >&3
  npm install -g pure-prompt

  echo "(done)" >&3
}

install_node_stable_packages
