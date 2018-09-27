#!/usr/bin/env bash
#
# MongoDB functions

set -Eeoux pipefail

source ./lib/utilities.sh

mongodb_prepare () {
  cached_sudo mkdir -p /data/db
  cached_sudo chown -R `whoami` /data
  echo "(done)" >&3
}

mongodb_prepare
