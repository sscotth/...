#!/usr/bin/env bash
#
# Node.js functions

setup_node_stable () {
  . ~/.nvm/nvm.sh

  nvm use node

  npm config set init-author-name "Scott Humphries"
  npm config set init-author-email "npm@sscotth.io"
  npm config set init-author-url "https://sscotth.io"
  npm config set init-license "MIT"

  # https://github.com/npm/npm/issues/11283
  npm config set progress false
}

setup_node_stable
