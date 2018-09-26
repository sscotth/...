#!/usr/bin/env bash

source ./.extra

zap () {
  echo "Homebrew Zaps:"
  echo $HOMEBREW_ZAPS

  for i in ${HOMEBREW_ZAPS[@]}; do
    echo ZAPPING: $i
    brew cask zap $i
  done
}

zap
