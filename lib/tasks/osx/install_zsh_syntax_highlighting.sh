#!/usr/bin/env bash
#
# ZSH Functions

install_zsh_syntax_highlighting () {
  rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  GIT_TRACE=2 GIT_CURL_VERBOSE=2 GIT_TRACE_PERFORMANCE=2 GIT_TRACE_PACK_ACCESS=2 GIT_TRACE_PACKET=2 GIT_TRACE_PACKFILE=2 GIT_TRACE_SETUP=2 GIT_TRACE_SHALLOW=2 git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

install_zsh_syntax_highlighting
