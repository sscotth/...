#!/usr/bin/env bash
#
# NTP time pool setup

set -Eeoux pipefail

source ./lib/utilities.sh

use_ntp_pool_servers () {
  cached_sudo ln -sf ~/.dotfiles/ntp.conf /etc/ntp.conf

  ntpq -np
  echo "(done)" >&3
}

use_ntp_pool_servers
