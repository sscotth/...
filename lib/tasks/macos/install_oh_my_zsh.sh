#!/usr/bin/env bash
#
# ZSH Functions

set -Eeoux pipefail

source ./lib/utilities.sh

install_oh_my_zsh () {
  # rm -rf ${HOME}/.oh-my-zsh

  # Manual Installation
  git_clone_or_pull https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh --depth 1

  # echo "(Clone the repository)" >&3
  # git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  echo "(Optionally, backup your existing ~/.zshrc file)" >&3
  # cp ~/.zshrc ~/.zshrc.orig

  echo "(Create a new zsh configuration file)" >&3
  # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

  echo "(Change your default shell)" >&3
  cached_sudo chsh -s /usr/local/bin/zsh $(whoami) # brew version

  echo "(done)" >&3
}

install_oh_my_zsh
