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

mathiasbynens_dotfiles_load
