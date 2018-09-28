#!/usr/bin/env bash
#
# MathiasBynens' dotfiles functions

set -Eeoux pipefail

source ./lib/utilities.sh

mathiasbynens_dotfiles_download () {
  if [ -d "math_dotfiles" ]; then
    echo "(Pull)" >&3
    git -C ./math_dotfiles reset --hard
    git -C ./math_dotfiles pull origin master
  else
    echo "(Clone)" >&3
    git_clone_or_pull https://github.com/mathiasbynens/dotfiles math_dotfiles --depth 1
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
