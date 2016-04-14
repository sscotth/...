#!/usr/bin/env bash
#
# Clean .DS_Store files

clean_DS_Store () {
  sudo find / -name ".DS_Store" -depth -exec rm {} \;
  # find . -type f -name '*.DS_Store' -ls -delete
}
