#!/usr/bin/env bash
#
# Android Studio

set -Eeoux pipefail

android_studio () {
  boxecho "Creating directories"
  echo "(creating directories)" >&3
  mkdir -p ~/Library/Android/sdk/tools/bin

  cd ~/Library/Android/sdk/tools/bin

  boxecho "Update SDKs"
  echo "(updating SDKs)" >&3
  ./sdkmanager --update

  boxecho "Accept Licenses"
  echo "(accepting licenses)" >&3
  yes | ./sdkmanager --licenses

  echo "(done)" >&3
}

android_studio
