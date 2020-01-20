#!/usr/bin/env bash
#
# Disable malicious check 

set -Eeoux pipefail

source ./lib/utilities.sh

disable_malicious_check () {
  echo "Disable malicious check"
  cached_sudo spctl --master-disable

  echo "(done)" >&3
}

disable_malicious_check
