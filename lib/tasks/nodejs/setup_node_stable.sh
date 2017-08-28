#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

setup_node_stable () {
  load_nvm

  nvm use node

  npm config set init-author-name "Scott Humphries"
  npm config set init-author-email "npm@sscotth.io"
  npm config set init-author-url "https://sscotth.io"
  npm config set init-license "MIT"

  # https://github.com/npm/npm/issues/11283 (Fixed in v3.10.0: https://github.com/npm/npm/releases/tag/v3.10.0)
  npm config set progress true
}

setup_node_stable
