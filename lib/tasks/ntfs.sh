#!/usr/bin/env bash
#
# NTFS-3G functions

ntfs_prepare () {
  if csrutil status | grep "System Integrity Protection status: disabled"; then
    if [ -f /sbin/mount_ntfs ]; then
      sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.original
    fi
    sudo ln -sf /usr/local/sbin/mount_ntfs /sbin/mount_ntfs
  else
    echo "(ERROR: SIP Enabled)" >&3
    false
  fi
}
