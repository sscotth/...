#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

clean_npm_cache () {
  load_nvm

  npm cache clean
}

clean_npm_cache
