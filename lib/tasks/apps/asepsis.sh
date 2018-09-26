#!/usr/bin/env bash

asepsis () {
  if csrutil status | grep "System Integrity Protection status: disabled"; then
    echo "System Integrity Protection status: disabled."
    # SKIP FOR NOW
    # # Fix asepsis failed update notifications
    # asepsisctl uninstall_updater
  else
    echo "System Integrity Protection status: enabled."
    echo "(ERROR: SIP Enabled)" >&3
    return 72 # critical OS file missing
  fi
}

asepsis
