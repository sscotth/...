#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

# HOMEBREW_ZAPS=(
#   screens # early sudo
#   busycal
#   busycontacts
#   charles
#   devonthink-pro-office
#   fantastical
#   glyphs
#   kaleidoscope
#   little-snitch
#   marked
#   monodraw
#   moom
#   navicat-premium
#   omnifocus
#   parallels
#   sound-control
#   tower
#   vmware-fusion
# )

HOMEBREW_ZAPS=(${HOMEBREW_ZAPS:-nothing})

homebrew_zap () {
  boxecho "Homebrew Zaps: ${HOMEBREW_ZAPS}"

  if [ ${HOMEBREW_ZAPS[0]} == "nothing" ]; then
    boxecho "No HOMEBREW_ZAPS"
    echo "(No zaps)" >&3
  else
    for i in ${HOMEBREW_ZAPS[@]}; do
      boxecho ZAPPING: $i
      echo $i >&3

      brew cask zap $i || true
      brew cask zap -f $i || true
    done
    echo "(done)" >&3
  fi
}

homebrew_zap
