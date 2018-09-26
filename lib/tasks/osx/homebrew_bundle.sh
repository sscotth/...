#!/usr/bin/env bash

homebrew_bundle () {
  echo "Homebrew installs (bundle)"
  echo "Sleep 120"
  sleep 120
  cached_psudo brew bundle --verbose --file=.Brewfile
}

homebrew_bundle
