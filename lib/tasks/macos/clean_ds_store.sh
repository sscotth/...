#!/usr/bin/env bash
#
# Clean .DS_Store files

source ./lib/utilities.sh

clean_DS_Store () {
  cached_sudo 'find / -name ".DS_Store" -depth -exec rm {} \;' || true
  ! cached_sudo 'find / -name ".DS_Store" 2>/dev/null | grep .DS_Store'
  # find . -type f -name '*.DS_Store' -ls -delete
}

clean_DS_Store
