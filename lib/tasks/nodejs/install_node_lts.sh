#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

install_node_lts () {
  load_nvm

  nvm install --lts
  nvm install --lts=Carbon # 8.x
  nvm install --lts=Boron # 6.x
  nvm install --lts=Argon # 4.x

}

install_node_lts
