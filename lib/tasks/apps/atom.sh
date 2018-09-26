#!/usr/bin/env bash

atom_plugins () {

  [[ $(command -v apm) == "" ]] && echo "Installing Atom" && brew cask install atom

  echo "Install atom plugins"
  apm stars --user sscotth
  apm stars --user sscotth --install

  echo "Upgrade atom packages"
  yes | apm upgrade

}

atom_plugins
