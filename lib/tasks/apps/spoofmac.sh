#!/usr/bin/env bash

source ./lib/utilities.sh

python_spoofmac () {

  echo "Install SpoofMAC"
  pip install SpoofMAC

  # Finish SpoofMAC Install https://github.com/feross/SpoofMAC#startup-installation-instructions
  echo "Download the startup file for launchd"
  curl https://raw.githubusercontent.com/feross/SpoofMAC/master/misc/local.macspoof.plist > /tmp/local.macspoof.plist

  echo "Customize location of `spoof-mac.py` to match your system"
  cat /tmp/local.macspoof.plist | sed "s|/usr/local/bin/spoof-mac.py|`which spoof-mac.py`|" | tee /tmp/local.macspoof.plist

  echo "Copy file to the OS X launchd folder"
  cached_sudo cp /tmp/local.macspoof.plist /Library/LaunchDaemons

  echo "Set file permissions"
  cached_sudo chown root:wheel /Library/LaunchDaemons/local.macspoof.plist
  cached_sudo chmod 0644 /Library/LaunchDaemons/local.macspoof.plist
}

python_spoofmac
