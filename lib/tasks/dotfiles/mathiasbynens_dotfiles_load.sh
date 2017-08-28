#!/usr/bin/env bash
#
# MathiasBynens' dotfiles functions

source ./lib/utilities.sh

mathiasbynens_dotfiles_load () {
  if [ -d "math_dotfiles" ]; then
    echo "(Pulling with git)" >&3
    cd math_dotfiles
    git checkout .
    git pull origin master
    cd ..
  else
    echo "(Cloning with git)" >&3
    GIT_TRACE=2 GIT_CURL_VERBOSE=2 GIT_TRACE_PERFORMANCE=2 GIT_TRACE_PACK_ACCESS=2 GIT_TRACE_PACKET=2 GIT_TRACE_PACKFILE=2 GIT_TRACE_SETUP=2 GIT_TRACE_SHALLOW=2 git clone --depth 1 https://github.com/mathiasbynens/dotfiles math_dotfiles
  fi

  cached_psudo ./math_dotfiles/.macos
}

mathiasbynens_dotfiles_load
