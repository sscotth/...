#!/usr/bin/env bash
#
# ZSH Functions

set -Eeoux pipefail

load_zshrc_from_oh_my_zsh () {
  # make sure .zshrc is fresh
  rm ~/.zshrc || true
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

  # add .zsh_profile reference to .zshrc
  echo 'source ~/.zsh_profile' >> ~/.zshrc

  # symlink zshrc back to the .dotfiles repo
  # ln -sf ~/.zshrc ~/.dotfiles/.zshrc

  echo "(done)" >&3
}

load_zshrc_from_oh_my_zsh
