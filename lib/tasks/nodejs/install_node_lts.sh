#!/usr/bin/env bash
#
# Node.js functions

set -Eeoux pipefail

source ./lib/utilities.sh

export NVM_SYMLINK_CURRENT=true

install_node_lts () {
  load_nvm

  local installed_versions=""

  boxecho "Argon v4.x"
  echo "(Installing Argon v4.x...)" >&3
  nvm install --lts=Argon
  installed_versions=$(node -v)
  echo "($installed_versions)" >&3

  boxecho "Boron v6.x"
  echo "(Installing Boron v6.x...)" >&3
  nvm install --lts=Boron
  installed_versions="${installed_versions}, $(node -v)"
  echo "($installed_versions)" >&3

  boxecho "Carbon v8.x"
  echo "(Installing Carbon v8.x...)" >&3
  nvm install --lts=Carbon
  installed_versions="${installed_versions}, $(node -v)"
  echo "($installed_versions)" >&3

  boxecho "Dubnium v10.x"
  echo "(Installing Dubnium v10.x...)" >&3
  nvm install --lts=Dubnium
  installed_versions="${installed_versions}, $(node -v)"
  echo "($installed_versions)" >&3
}

install_node_lts
