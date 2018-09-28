#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick_atom () {
  boxecho "Homebrew quick installs"

  boxecho "Atom"
  ! command_exists apm && echo "Installing Atom" && brew cask install atom

  local installed_versions="Atom v$(atom --version | grep Atom | sed 's/^.*://' | awk '{$1=$1};1')"
  echo "($installed_versions)" >&3

  boxecho "jq"
  ! command_exists jq && echo "Installing jq" && brew install jq

  installed_versions="$installed_versions, $(jq --version)"
  echo "($installed_versions)" >&3
}

homebrew_quick_atom
