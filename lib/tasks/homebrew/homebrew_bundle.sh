#!/usr/bin/env bash

homebrew_bundle () {
  echo "Homebrew installs (bundle)"
  echo "Sleep 120"
  sleep 120
  echo "Brew bundle"
  brew bundle --verbose --file=.Brewfile
}

homebrew_bundle
