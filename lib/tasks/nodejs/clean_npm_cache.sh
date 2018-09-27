#!/usr/bin/env bash
#
# Node.js functions

set -Eeoux pipefail

source ./lib/utilities.sh

clean_npm_cache () {
  load_nvm

  npm cache clean --force

  echo "(done)" >&3
}

clean_npm_cache
