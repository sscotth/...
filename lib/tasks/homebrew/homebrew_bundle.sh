#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

homebrew_bundle () {
  echo "Homebrew installs (bundle)"
  echo "Long wait..." >&3
  cached_psudo brew bundle --file=.Brewfile
  echo "(done)" >&3
}

homebrew_bundle
