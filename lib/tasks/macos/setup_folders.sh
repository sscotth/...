#!/usr/bin/env bash
#
# Setup required folders

set -Eeoux pipefail

setup_folders () {
  mkdir -p ~/code/clients
  mkdir -p ~/code/forks
  mkdir -p ~/code/projects
  mkdir -p ~/code/testing

  ln -sf ~/.dotfiles ~/code/projects/dotfiles
}

setup_folders
