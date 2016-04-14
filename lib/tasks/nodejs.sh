#!/usr/bin/env bash
#
# Node.js functions

export NVM_SYMLINK_CURRENT=true

install_node_version_manager () {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  . ~/.nvm/nvm.sh

  my_sleep "${@}"
}

install_node_stable () {
  if nvm which node &> /dev/null; then
    echo "(Reinstalling Packages)" >&3
    nvm install node --reinstall-packages-from=node
  else
    echo "Initial Install"
    nvm install node
  fi

  echo "Setup alias"
  nvm alias default node

  echo "Update npm"
  npm install -g npm

  my_sleep "${@}"
}

install_node_lts () {
  local $version="v4"

  if nvm which $version &> /dev/null; then
    echo "(Reinstalling Packages)" >&3
    nvm install $version --reinstall-packages-from=$version
  else
    echo "Initial Install"
    nvm install $version
  fi

  echo "Setup alias"
  nvm alias lts $version

  echo "Update npm"
  npm install -g npm

  my_sleep "${@}"
}

setup_node_stable () {
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
  nvm use node
  npm cache clean

  npm install -g babel-eslint
  npm install -g bower
  npm install -g cordova
  npm install -g diff-so-fancy
  npm install -g eslint
  npm install -g grunt-cli
  npm install -g gulp
  npm install -g http-server
  npm install -g ionic
  npm install -g jshint
  npm install -g pm2
  npm install -g semistandard
  npm install -g semistandard-format

  npm cache clean

  my_sleep "${@}"
}


install_node_lts_packages () {
  nvm use lts
  npm cache clean

  npm install -g ionic

  npm cache clean

  my_sleep "${@}"
}
