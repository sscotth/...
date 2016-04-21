#!/usr/bin/env bash
#
# MongoDB functions

mongodb_prepare () {
  sudo mkdir -p /data/db
  sudo chown -R `whoami` /data
}
