#!/usr/bin/env bash
#
# MathiasBynens' dotfiles functions

mathiasbynens_dotfiles_symlink () {
  echo "symlinking selected mathiasbynens dotfiles"
  for file in $HOME/.dotfiles/math_dotfiles/.{bashrc,curlrc,gitconfig,hushlogin,inputrc,wgetrc,extra}; do
    dst="$HOME/$(basename $file)"
    [ -r $file ] && [ -f $file ] && echo "$file ==> $dst" && ln -sf $file $dst
  done;
}

mathiasbynens_dotfiles_symlink
