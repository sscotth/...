#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

clean_npm_cache () {
  load_nvm

  npm cache clean --force
}

clean_npm_cache
