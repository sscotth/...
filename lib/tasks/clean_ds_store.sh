#!/usr/bin/env bash
#
# Clean .DS_Store files

clean_DS_Store () {
  sudo find / -name ".DS_Store" -depth -exec rm {} \;
  ! sudo find / -name '.DS_Store' 2>/dev/null | grep .DS_Store
  # find . -type f -name '*.DS_Store' -ls -delete
}
