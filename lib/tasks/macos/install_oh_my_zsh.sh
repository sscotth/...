#!/usr/bin/env bash
#
# ZSH Functions

set -Eeoux pipefail

source ./lib/utilities.sh

install_oh_my_zsh () {
  rm -rf ${HOME}/.oh-my-zsh

  # cached_psudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  # Manual Installation
  echo "(Clone the repository)" >&3
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  echo "(Optionally, backup your existing ~/.zshrc file)" >&3
  # cp ~/.zshrc ~/.zshrc.orig

  echo "(Create a new zsh configuration file)" >&3
  # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

  echo "(Change your default shell)" >&3
  cached_psudo chsh -s /bin/zsh

  echo "(done)" >&3
}

install_oh_my_zsh

# curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /tmp/omz-install.sh

# remove changing of shell actions from omz-install script
# sed -E '/.*(chsh -s|env zsh)/d' /tmp/omz-install.sh > /tmp/omz-install-nochsh.sh

# sh /tmp/omz-install.sh
# sh /tmp/omz-install-nochsh.sh
#
