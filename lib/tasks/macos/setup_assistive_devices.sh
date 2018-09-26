#!/usr/bin/env bash
#
# SUDO: Setup Assistive Devices

source ./lib/utilities.sh

setup_assistive_devices () {
  if csrutil status | grep "System Integrity Protection status: disabled"; then
    echo "System Integrity Protection status: disabled."
    echo "Adding Terminal to assistive devices"
    brew update
    brew install tccutil

    cached_sudo tccutil -i com.apple.Terminal

    # Check list before completing
    cached_sudo tccutil -l | grep com.apple.Terminal
  else
    echo "System Integrity Protection status: enabled."
    echo "(ERROR: SIP Enabled)" >&3
    return 72 # critical OS file missing
  fi
}

setup_assistive_devices
