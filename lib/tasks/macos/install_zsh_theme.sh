#!/usr/bin/env bash
#
# ZSH Functions

set -Eeoux pipefail

source ./lib/utilities.sh

install_zsh_theme () {

  echo "(Clone the repository)" >&3
  git_clone_or_pull https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k --depth 1

  echo "(Edit ZSH_THEME in .zshrc)" >&3


  echo "(done)" >&3
}

install_zsh_theme
