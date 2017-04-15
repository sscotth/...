#!/usr/bin/env bash
#
# Install stronger hosts file
# https://github.com/StevenBlack/hosts

install_hosts_file () {
  sudo sh -c "curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts > /etc/hosts"
}

install_hosts_file
