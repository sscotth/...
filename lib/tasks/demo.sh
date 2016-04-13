#!/usr/bin/env bash
#
# Example functions

create_vm () {
  local provider=digitalocean
  echo "(on ${provider})" >&3
  my_sleep "${@}"
}

restore_data () {
  local data_source=dropbox
  echo "(with ${data_source})" >&3
  my_sleep "${@}"
}

my_sleep () {
    local seconds=${1}
    local code=${2:-0}
    echo "Yay! Sleeping for ${seconds} second(s)!"
    sleep "${seconds}"
    if [ "${code}" -ne 0 ]; then
        echo "Oh no! Terrible failure!" 1>&2
    fi
    return "${code}"
}
