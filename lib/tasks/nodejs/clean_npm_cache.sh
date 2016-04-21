#!/usr/bin/env bash
#
# Node.js functions

clean_npm_cache () {
  . ~/.nvm/nvm.sh

  npm cache clean
}

clean_npm_cache
