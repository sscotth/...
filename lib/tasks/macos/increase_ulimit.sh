#!/usr/bin/env bash
#
# NTP time pool setup

set -Eeoux pipefail

source ./lib/utilities.sh

increase_ulimit () {
  # https://unix.stackexchange.com/a/221988

  cached_psudo ln -sf ~/.dotfiles/limit.maxfiles.plist /Library/LaunchDaemons/limit.maxfiles.plist
  cached_sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist
  cached_sudo chmod 0644 /Library/LaunchDaemons/limit.maxfiles.plist

  ulimit -a

  echo "(done. requires restart)" >&3
}

increase_ulimit
