#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

atom_plugins () {

  boxecho $(atom -v)

  boxecho "Install atom plugins"
  echo "(Installing...)" >&3
  apm stars --user sscotth
  apm stars --user sscotth --install

  boxecho "Upgrade atom packages"
  echo "(Upgrading)" >&3
  yes | apm upgrade || true

  boxecho "done"
  echo "(done)" >&3
}

atom_plugins
