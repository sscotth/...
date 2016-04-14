#!/usr/bin/env bash
#
# Node.js functions

export NVM_SYMLINK_CURRENT=true

install_node_version_manager () {
  # remove nvm, npm, and installed nodes
  rm -rf ~/.nvm ~/.npm

  curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  . ~/.nvm/nvm.sh

  my_sleep "${@}"
}

install_node_stable () {
  . ~/.nvm/nvm.sh

  nvm install node

  echo "Setup alias"
  nvm alias default node

  echo "Update npm"
  npm install -g npm

  my_sleep "${@}"
}

install_node_lts () {
  local version=v4
  . ~/.nvm/nvm.sh

  nvm install $version

  echo "Setup alias"
  nvm alias lts $version

  echo "Update npm"
  npm install -g npm

  my_sleep "${@}"
}

setup_node_stable () {
  . ~/.nvm/nvm.sh

  nvm use node

  npm config set init-author-name "Scott Humphries"
  npm config set init-author-email "npm@sscotth.io"
  npm config set init-author-url "https://sscotth.io"
  npm config set init-license "MIT"

  # https://github.com/npm/npm/issues/11283
  npm config set progress false

  my_sleep "${@}"
}

setup_node_lts () {
  . ~/.nvm/nvm.sh

  nvm use lts

  npm config set init-author-name "Scott Humphries"
  npm config set init-author-email "npm@sscotth.io"
  npm config set init-author-url "https://sscotth.io"
  npm config set init-license "MIT"

  # https://github.com/npm/npm/issues/11283
  npm config set progress false

  my_sleep "${@}"
}

install_node_stable_packages () {
  . ~/.nvm/nvm.sh

  nvm use node

  echo "(babel-eslint)" >&3
  npm install -g babel-eslint
  echo "(bower)" >&3
  npm install -g bower
  echo "(cordova)" >&3
  npm install -g cordova
  echo "(diff-so-fancy)" >&3
  npm install -g diff-so-fancy
  echo "(eslint)" >&3
  npm install -g eslint
  echo "(grunt-cli)" >&3
  npm install -g grunt-cli
  echo "(gulp)" >&3
  npm install -g gulp
  echo "(http-server)" >&3
  npm install -g http-server
  echo "(ionic)" >&3
  npm install -g ionic
  echo "(jshint)" >&3
  npm install -g jshint
  echo "(pm2)" >&3
  npm install -g pm2
  echo "(semistandard)" >&3
  npm install -g semistandard
  echo "(semistandard-format)" >&3
  npm install -g semistandard-format

  echo "(done)" >&3

  my_sleep "${@}"
}


install_node_lts_packages () {
  . ~/.nvm/nvm.sh

  nvm use lts

  echo "(ionic)" >&3
  npm install -g ionic

  echo "(done)" >&3

  my_sleep "${@}"
}

clean_npm_cache () {
  npm cache clean

  my_sleep "${@}"
}
