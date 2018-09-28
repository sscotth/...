#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_quick_ruby () {
  boxecho "Homebrew quick installs"

  boxecho "ruby-install"

  ! command_exists ruby-install && echo "Installing ruby-install" && brew install ruby-install
  local installed_versions=$(ruby-install --version)
  echo "($installed_versions)" >&3

  boxecho "chruby"

  ! command_exists chruby && echo "Installing chruby" && brew install chruby
  installed_versions="$installed_versions, $(chruby --version)"
  echo "($installed_versions)" >&3
}

homebrew_quick_ruby
