#!/usr/bin/env bash
#
# Install apps from the App Store

install_app_store_apps () {
  osascript -l JavaScript appstore.js
}
