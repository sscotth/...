#!/usr/bin/env bash
#
# NTP time pool setup

set -Eeoux pipefail

source ./lib/utilities.sh

get_current_time () {
  cached_sudo sntp -sS pool.ntp.org
}

use_ntp_pool_servers () {
  cached_sudo ln -sf ~/.dotfiles/ntp.conf /etc/ntp.conf
  ntpq -np
}

ntp_time_setup () {
  get_current_time
  # use_ntp_pool_servers
  echo "(done)" >&3
}

ntp_time_setup
