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
