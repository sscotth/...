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
  echo "Sleeping for ${seconds} second(s)!"
  sleep "${seconds}"
}
