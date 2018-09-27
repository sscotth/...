#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

asepsis () {
  if csrutil status | grep "System Integrity Protection status: disabled"; then
    boxecho "System Integrity Protection status: disabled."
    # SKIP FOR NOW
    # # Fix asepsis failed update notifications
    # asepsisctl uninstall_updater
  else
    boxecho "System Integrity Protection status: enabled."
    echo "(ERROR: SIP Enabled)" >&3
    return 72 # critical OS file missing
  fi
  echo "(done)" >&3
}

asepsis
