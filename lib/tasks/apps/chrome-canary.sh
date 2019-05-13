#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

chromecanary () {
  boxecho "Chrome Canary 1password fix"
  # https://discussions.agilebits.com/discussion/97362/using-the-browser-extension-on-chrome-canary-not-working-anymore

  mkdir -p ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/
  mkdir -p ~/Library/Application\ Support/Google/Chrome\ Canary/NativeMessagingHosts

  touch ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/2bua8c4s2c.com.agilebits.1password.json

  ln -sf \
    ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/2bua8c4s2c.com.agilebits.1password.json \
    ~/Library/Application\ Support/Google/Chrome\ Canary/NativeMessagingHosts/2bua8c4s2c.com.agilebits.1password.json

  echo "(done)" >&3
}

chromecanary
