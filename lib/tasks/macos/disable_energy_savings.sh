#!/usr/bin/env bash
#
# Disable energy saving features during install

energy () {
  echo "Never go into computer sleep mode"

  # Never go into computer sleep mode during install
    # Usage: systemsetup -setcomputersleep <minutes>
  	# Set amount of idle time until compputer sleeps to <minutes>.
  	# Specify "Never" or "Off" for never.

  cached_sudo systemsetup -setcomputersleep Off
  cached_sudo pmset -a displaysleep 0

  # Never dim display during install (needed?)
  # cached_sudo pmset force -a displaysleep 0

  echo "Disable screensaver"

  # Disable screensaver during install
  defaults -currentHost write com.apple.screensaver idleTime 0
}

energy
