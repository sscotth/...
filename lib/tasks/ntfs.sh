#!/usr/bin/env bash
#
# NTFS-3G functions

ntfs_prepare () {
  if [ -f /sbin/mount_ntfs ]; then
    sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.original
  fi
  sudo ln -sf /usr/local/sbin/mount_ntfs /sbin/mount_ntfs

  my_sleep "${@}"
}
