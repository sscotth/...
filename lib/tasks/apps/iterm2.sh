#!/usr/bin/env bash

set -Eeoux pipefail

source ./lib/utilities.sh

iterm2 () {
  boxecho "iterm2 shell integration"

  curl -L https://iterm2.com/misc/install_shell_integration.sh | bash
  echo "(done)" >&3
}

iterm2
