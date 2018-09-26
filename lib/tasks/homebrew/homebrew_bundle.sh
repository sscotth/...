#!/usr/bin/env bash

source ./lib/utilities.sh

homebrew_bundle () {
  echo "Homebrew installs (bundle)"
  cached_psudo brew bundle --file=.Brewfile
}

homebrew_bundle
