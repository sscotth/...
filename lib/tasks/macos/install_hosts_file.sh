#!/usr/bin/env bash
#
# Install stronger hosts file
# https://github.com/StevenBlack/hosts

set -Eeoux pipefail

source ./lib/utilities.sh

install_hosts_file () {
  cached_sudo curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o /etc/hosts
  echo "(done)" >&3
}

install_hosts_file
