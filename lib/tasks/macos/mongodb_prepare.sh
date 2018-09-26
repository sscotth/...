#!/usr/bin/env bash
#
# MongoDB functions

source ./lib/utilities.sh

mongodb_prepare () {
  cached_sudo mkdir -p /data/db
  cached_sudo chown -R `whoami` /data
}

mongodb_prepare
