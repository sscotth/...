#!/usr/bin/env bash
#
# Generate SSH KEY

set -Eeoux pipefail

generate_ssh_keys () {
  SSH_KEY_PW=""

  # Ask for password
  # read -s -p "SSH KEYPassword:" SSH_KEY_PW
  # echo ""

  if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -C "scott@sscotth.io" -N "$ssh_key_pw" -f ~/.ssh/id_rsa
  fi

  ssh-add ~/.ssh/id_rsa
  echo "(done)" >&3
}

generate_ssh_keys
