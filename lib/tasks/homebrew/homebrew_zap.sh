#!/usr/bin/env bash

zap () {
  for i in ${HOMEBREW_ZAPS[@]}; do
    echo ZAPPING: $i
    brew cask zap $i
  done
}

zap
