#!/usr/bin/env bash

set -Eeox pipefail
# Cant use -u: /usr/local/opt/chruby/share/chruby/chruby.sh: line 4: PREFIX: unbound variable

source ./lib/utilities.sh

homebrew_quick_ruby () {
  boxecho "Homebrew quick installs"

  boxecho "ruby-install"

  ! command_exists ruby-install && echo "Installing ruby-install" && brew install ruby-install
  local installed_versions=$(ruby-install --version)
  echo "($installed_versions)" >&3

  boxecho "chruby"
  source /usr/local/opt/chruby/share/chruby/chruby.sh || true

  ! command_exists chruby && echo "Installing chruby" && brew install chruby

  source /usr/local/opt/chruby/share/chruby/chruby.sh

  installed_versions="$installed_versions, $(chruby --version)"
  echo "($installed_versions)" >&3
}

homebrew_quick_ruby
