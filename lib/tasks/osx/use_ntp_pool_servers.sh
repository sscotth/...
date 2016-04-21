#!/usr/bin/env bash
#
# NTP time pool setup

use_ntp_pool_servers () {
  sudo ln -sf ~/.dotfiles/ntp.conf /etc/ntp.conf

  ntpq -np
}

use_ntp_pool_servers
