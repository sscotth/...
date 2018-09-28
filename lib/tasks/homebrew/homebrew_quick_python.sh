#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick_python () {
  boxecho "Homebrew quick installs"

  boxecho "Python"
  echo "(Python)" >&3
  ! command_exists pip && echo "Installing python v2" && brew install python@2
  local installed_versions=$(python --version)
  echo "($installed_versions)" >&3
  ! command_exists pip3 && echo "Installing python v3" && brew install python
  installed_versions="$installed_versions, $(python3 --version)"
  echo "($installed_versions)" >&3
}

homebrew_quick_python
