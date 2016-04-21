#!/usr/bin/env bash
#
# ZSH Functions

install_zsh_syntax_highlighting () {
  rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

install_zsh_syntax_highlighting
