#!/usr/bin/env bash
#
# ZSH Functions

load_zshrc_from_oh_my_zsh () {
  # make sure .zshrc is fresh
  rm ~/.zshrc
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

  # add .zsh_profile reference to .zshrc
  echo 'source ~/.zsh_profile' >> ~/.zshrc

  # symlink zshrc back to the .dotfiles repo
  # ln -sf ~/.zshrc ~/.dotfiles/.zshrc
}

load_zshrc_from_oh_my_zsh
