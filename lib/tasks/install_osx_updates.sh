#!/usr/bin/env bash
#
# SUDO: Load OSX Updates

install_osx_updates () {
  sudo softwareupdate -iva

  my_sleep "${@}"
}
