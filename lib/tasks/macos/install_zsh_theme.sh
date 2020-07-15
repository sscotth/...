#!/usr/bin/env bash
#
# ZSH Functions

set -Eeoux pipefail

source ./lib/utilities.sh

install_zsh_theme () {

  echo "(Link the homebrew)" >&3
  ln -sf /usr/local/opt/powerlevel10k ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  echo "(Edit ZSH_THEME in .zshrc)" >&3
  sed -i "" 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

  echo "(done)" >&3
}

install_zsh_theme
