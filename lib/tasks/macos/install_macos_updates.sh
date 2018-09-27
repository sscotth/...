#!/usr/bin/env bash
#
# SUDO: Load OSX Updates

set -Eeoux pipefail

source ./lib/utilities.sh

install_macos_updates () {
  cached_sudo softwareupdate -iva
  echo "(done)" >&3
}

install_macos_updates
