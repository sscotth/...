#!/usr/bin/env bash

source ./lib/utilities.sh

homebrew_bundle () {
  echo "Homebrew installs (bundle)"
  echo "Long wait..." >&3
  cached_psudo brew bundle --file=.Brewfile >&3
}

homebrew_bundle
