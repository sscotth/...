#!/usr/bin/env bash
#
# Node.js functions

set -Eeoux pipefail

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

install_node_stable () {
  load_nvm

  boxecho "Install Node.js Latest"
  nvm install node

  boxecho "Set as default"
  nvm alias default node

  echo "($(node -v))" >&3
}

install_node_stable
