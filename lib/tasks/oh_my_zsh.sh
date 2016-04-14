#!/usr/bin/env bash
#
# Install Oh-My-ZSH

install_oh_my_zsh () {
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /tmp/omz-install.sh

  # remove changing of shell actions from omz-install script
  sed -E '/.*(chsh -s|env zsh)/d' /tmp/omz-install.sh > /tmp/omz-install-nochsh.sh

  # sh /tmp/omz-install.sh
  sh /tmp/omz-install-nochsh.sh

  my_sleep "${@}"
}
