#!/usr/bin/env bash
#
# SUDO: Load OSX Updates

source ./lib/utilities.sh

install_osx_updates () {
  cached_sudo softwareupdate -iva
}

install_osx_updates
