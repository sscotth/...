#!/usr/bin/env bash
#
# MathiasBynens' dotfiles functions

mathiasbynens_dotfiles_load () {
  if [ -d "math_dotfiles" ]; then
    echo "(Pulling with git)" >&3
    cd math_dotfiles
    git checkout .
    git pull origin master
    cd ..
  else
    echo "(Cloning with git)" >&3
    git clone --depth 1 https://github.com/mathiasbynens/dotfiles math_dotfiles
  fi
}

mathiasbynens_dotfiles_symlink () {
  echo "symlinking selected mathiasbynens dotfiles"
  for file in $HOME/.dotfiles/math_dotfiles/.{bashrc,curlrc,gitconfig,hushlogin,inputrc,wgetrc,extra}; do
    dst="$HOME/$(basename $file)"
    [ -r $file ] && [ -f $file ] && echo "$file ==> $dst" && ln -sf $file $dst
  done;
}
