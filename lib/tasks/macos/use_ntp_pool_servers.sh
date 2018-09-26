#!/usr/bin/env bash
#
# NTP time pool setup

source ./lib/utilities.sh

use_ntp_pool_servers () {
  cached_sudo ln -sf ~/.dotfiles/ntp.conf /etc/ntp.conf

  ntpq -np
}

use_ntp_pool_servers
