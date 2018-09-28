#!/usr/bin/env bash
#
# NTP time pool setup

set -Eeoux pipefail

source ./lib/utilities.sh

increase_ulimit () {
  # https://unix.stackexchange.com/a/221988

 local file='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>limit.maxfiles</string>
    <key>ProgramArguments</key>
    <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>262144</string>
      <string>524288</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
  </dict>
</plist>
'

  cached_psudo "echo $file | sudo tee /Library/LaunchDaemons/limit.maxfiles.plist"
  cached_sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist
  cached_sudo chmod 0644 /Library/LaunchDaemons/limit.maxfiles.plist

  ulimit -a

  echo "(done. requires restart)" >&3
}

increase_ulimit
