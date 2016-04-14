#!/usr/bin/env bash
#
# ZSH Functions

install_oh_my_zsh () {
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /tmp/omz-install.sh

  # remove changing of shell actions from omz-install script
  sed -E '/.*(chsh -s|env zsh)/d' /tmp/omz-install.sh > /tmp/omz-install-nochsh.sh

  # sh /tmp/omz-install.sh
  sh /tmp/omz-install-nochsh.sh

  my_sleep "${@}"
}

load_zshrc_from_oh_my_zsh () {
  # make sure .zshrc is fresh
  rm ~/.zshrc
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

  # add .zsh_profile reference to .zshrc
  echo 'source ~/.zsh_profile' >> ~/.zshrc

  # symlink zshrc back to the .dotfiles repo
  # ln -sf ~/.zshrc ~/.dotfiles/.zshrc

  my_sleep "${@}"
}

install_zsh_syntax_highlighting () {
  rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  my_sleep "${@}"
}
