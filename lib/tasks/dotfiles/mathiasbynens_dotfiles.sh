#!/usr/bin/env bash
#
# MathiasBynens' dotfiles functions

set -Eeoux pipefail

source ./lib/utilities.sh

mathiasbynens_dotfiles_download () {
  if [ -d "math_dotfiles" ]; then
    echo "(Pull)" >&3
    cd math_dotfiles
    git checkout .
    git pull origin master
    cd ..
  else
    echo "(Clone)" >&3
    GIT_TRACE=2 GIT_CURL_VERBOSE=2 GIT_TRACE_PERFORMANCE=2 GIT_TRACE_PACK_ACCESS=2 GIT_TRACE_PACKET=2 GIT_TRACE_PACKFILE=2 GIT_TRACE_SETUP=2 GIT_TRACE_SHALLOW=2 git clone --depth 1 https://github.com/mathiasbynens/dotfiles math_dotfiles
  fi
}

mathiasbynens_dotfiles_symlink () {
  boxecho "symlinking selected mathiasbynens dotfiles"
  for file in $HOME/.dotfiles/math_dotfiles/.{bashrc,curlrc,gitconfig,hushlogin,inputrc,wgetrc,extra}; do
    dst="$HOME/$(basename $file)"
    [ -r $file ] && [ -f $file ] && echo "$file ==> $dst" && ln -sf $file $dst || true
  done;
}

mathiasbynens_dotfiles () {
  mathiasbynens_dotfiles_download
  mathiasbynens_dotfiles_symlink
  echo "(done)" >&3
}

mathiasbynens_dotfiles
