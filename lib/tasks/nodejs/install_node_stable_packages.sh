#!/usr/bin/env bash
#
# Node.js functions

source ./lib/utilities.sh

install_node_stable_packages () {
  load_nvm

  nvm use node

  echo "(babel-eslint)" >&3
  npm install -g babel-eslint
  # echo "(bower)" >&3
  # npm install -g bower
  # echo "(cordova)" >&3
  # npm install -g cordova
  # echo "(eslint)" >&3
  # npm install -g eslint
  # echo "(grunt-cli)" >&3
  # npm install -g grunt-cli
  # echo "(gulp)" >&3
  # npm install -g gulp
  # echo "(http-server)" >&3
  # npm install -g http-server
  # echo "(ionic)" >&3
  # npm install -g ionic
  # echo "(jshint)" >&3
  # npm install -g jshint
  # echo "(localtunnel)" >&3
  # npm install -g localtunnel
  # echo "(nativescript)" >&3
  # npm install -g nativescript
  # echo "(node-gyp)" >&3
  # npm install -g node-gyp
  # echo "(npm-check-updates)" >&3
  # npm install -g npm-check-updates
  # echo "(pm2)" >&3
  # npm install -g pm2
  # echo "(pnpm)" >&3
  # npm install -g pnpm
  # echo "(react-native-cli)" >&3
  # npm install -g react-native-cli
  # echo "(semistandard)" >&3
  # npm install -g semistandard
  # echo "(semistandard-format)" >&3
  # npm install -g semistandard-format
  # echo "(standard)" >&3
  # npm install -g standard
  # echo "(standard-format)" >&3
  # npm install -g standard-format
  # echo "(verdaccio)" >&3
  # npm install -g verdaccio

  echo "(done)" >&3
}

install_node_stable_packages
