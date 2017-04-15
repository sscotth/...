#!/usr/bin/env bash
#
# utility functions

# Retries a command on failure
# Based on http://fahdshariff.blogspot.com/2014/02/retrying-commands-in-shell-scripts.html
# TODO: Accept optional MAX_ATTEMPTS and DELAY arguments
retry () {
    local -r -i MAX_ATTEMPTS=5
    local -r -i DELAY=10
    local -i index=1

    until $*; do
        if (( index == MAX_ATTEMPTS )); then
            echo "Attempt $index failed and there are no more attempts left!"
            echo "(Attempt $index failed!)" >&3
            return 1
        else
            echo "Attempt $index failed! Trying again in $(( DELAY * index )) seconds..."
            echo "(Attempt $index failed. Waiting $(( DELAY * index )) seconds...)" >&3
            sleep $(( DELAY * index++ ))
        fi
    done
}

# Caches the sudo password as a variable for scripts.
# Some scripts cannot be as sudo like homebrew, but requires a password during certain tasks.
# Use psudo for those scripts.
function cached_psudo () {
  if [ -z ${SUDOPASS+x} ]; then
    read -s -p "SUDO Password:" SUDOPASS
    export SUDOPASS=$SUDOPASS
    echo ''
  fi

  base64_cmd=$(echo $@ | base64)

  /usr/bin/expect <<EOD
    set timeout -1
    spawn ./lib/base64_eval.sh $base64_cmd
    expect {
      "*?assword:*" { send "$SUDOPASS\n"; exp_continue }
      eof
    }
    catch wait result
EOD
}

function cached_sudo () {
  if [ -z ${SUDOPASS+x} ]; then
    read -s -p "SUDO Password:" SUDOPASS
    export SUDOPASS=$SUDOPASS
    echo ''
  fi

  base64_cmd=$(echo sudo $@ | base64)

  /usr/bin/expect <<EOD
    set timeout -1
    spawn ./lib/base64_eval.sh $base64_cmd
    expect {
      "*?assword:*" { send "$SUDOPASS\n"; exp_continue }
      eof
    }
    catch wait result
EOD
}
