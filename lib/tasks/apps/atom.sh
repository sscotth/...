#!/usr/bin/env bash

atom_plugins () {

  echo "Install atom plugins"
  apm stars --user sscotth
  apm stars --user sscotth --install

  echo "Upgrade atom packages"
  yes | apm upgrade

}

atom_plugins
