#!/usr/bin/env bash
#
# SUDO: Setup Assistive Devices

setup_assistive_devices () {
  echo "Adding Terminal to assistive devices"
  brew update
  brew install tccutil

  /usr/bin/expect <<EOD
  set timeout 999
  spawn sudo tccutil -i com.apple.Terminal
  expect "Password:"
  send "$SUDOPASS\n"
  expect eof
EOD

  # Check list before completing
  sudo tccutil -l | grep com.apple.Terminal
}

setup_assistive_devices
