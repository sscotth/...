#!/usr/bin/env bash
#
# SUDO: Load OSX defaults

set -Eeoux pipefail

source ./lib/utilities.sh

load_macos_defaults () {
  mathiasbynens_macos_edit

  boxecho "mathiasbynens"
  mathiasbynens_macos_load

  boxecho "personal"
  personal_macos_load

  echo "(done. restart computer.)" >&3
}

### LOCAL ###

mathiasbynens_macos_edit () {
  echo "remove kill affected applicaitons at end of mathiasbynens .macos script"
  sed '/^# Kill affected applications/,$d' math_dotfiles/.macos > /tmp/.macos_nokill
}

mathiasbynens_macos_load () {
  echo "loading mathiasbynens' sensible hacker defaults"
  cd math_dotfiles
  yes | sh /tmp/.macos_nokill
  cd ..
}

personal_macos_load () {
  echo "loading personal macos preferences"
  sh .macos_supplement
}

load_macos_defaults
