#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

atom_plugins () {
  boxecho $(atom -v)

  boxecho "Getting Starred Packages"
  echo "(Getting Starred Packages...)" >&3
  apm stars --user sscotth --json | jq 'map(.name) | to_entries[] | .value' -r > /tmp/atom_starred_packages.txt

  boxecho "Checking Installed Packages"
  echo "(Checking Installed Packages...)" >&3
  apm list --installed --bare | sed 's/@.*//' > /tmp/atom_installed_packages.txt

  boxecho "Finding missing packages"
  echo "(Finding missing packages...)" >&3
  # https://stackoverflow.com/a/11100045
  local missing_packages=$(grep -Fxv -f /tmp/atom_installed_packages.txt /tmp/atom_starred_packages.txt)


  while read -r pkg; do
    boxecho "Installing: $pkg"
    echo "($pkg)" >&3
    apm install $pkg
  done <<< $missing_packages

  boxecho "Upgrading packages"
  echo "(Upgrading packages...)" >&3
  yes | apm upgrade || true

  echo "(done)" >&3
}

atom_plugins
