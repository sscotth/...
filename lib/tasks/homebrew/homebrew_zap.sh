#!/usr/bin/env bash

source ./.extra

homebrew_zap () {
  echo "Homebrew Zaps:"
  echo $HOMEBREW_ZAPS

  for i in ${HOMEBREW_ZAPS[@]}; do
    echo ZAPPING: $i

    brew cask zap $i
    brew cask zap -f $i
  done
}

homebrew_zap
