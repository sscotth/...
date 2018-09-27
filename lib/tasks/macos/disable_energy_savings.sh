#!/usr/bin/env bash
#
# Disable energy saving features during install

set -Eeoux pipefail

source ./lib/utilities.sh

disable_energy_savings () {
  echo "Never go into computer sleep mode"
  # Never go into computer sleep mode during install
    # Usage: systemsetup -setcomputersleep <minutes>
  	# Set amount of idle time until compputer sleeps to <minutes>.
  	# Specify "Never" or "Off" for never.
  cached_sudo systemsetup -setcomputersleep Off

  echo "Never turn off display"
  cached_sudo pmset -a displaysleep 0

  # Never dim display during install (needed?)
  # cached_sudo pmset force -a displaysleep 0

  echo "Disable screensaver"
  defaults -currentHost write com.apple.screensaver idleTime 0
  echo "(done)" >&3
}

disable_energy_savings
