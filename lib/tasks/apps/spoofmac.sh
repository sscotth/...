#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

python_spoofmac () {
  boxecho "Install SpoofMAC"

  pip install SpoofMAC

  boxecho "Finish SpoofMAC Install https://github.com/feross/SpoofMAC#startup-installation-instructions"

  boxecho "Download the startup file for launchd"
  echo "(lanchd)" >&3
  curl https://raw.githubusercontent.com/feross/SpoofMAC/master/misc/local.macspoof.plist > /tmp/local.macspoof.plist

  boxecho "Customize location of `spoof-mac.py` to match your system"
  echo "(custom location)" >&3
  cat /tmp/local.macspoof.plist | sed "s|/usr/local/bin/spoof-mac.py|`which spoof-mac.py`|" | tee /tmp/local.macspoof.plist

  boxecho "Copy file to the OS X launchd folder"
  echo "(copy)" >&3
  cached_sudo cp /tmp/local.macspoof.plist /Library/LaunchDaemons

  boxecho "Set file permissions"
  echo "(permissions)" >&3
  cached_sudo chown root:wheel /Library/LaunchDaemons/local.macspoof.plist
  cached_sudo chmod 0644 /Library/LaunchDaemons/local.macspoof.plist

  echo "(done)" >&3
}

python_spoofmac
