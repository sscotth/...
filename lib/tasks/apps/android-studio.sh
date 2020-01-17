#!/usr/bin/env bash
#
# Android Studio

set -Eeoux pipefail

source ./lib/utilities.sh

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

  boxecho "Wipe data"
  echo "(wipe data)" >&3
  for i in $(./emulator -list-avds); do
    ./emulator -avd $i -wipe-data -quit-after-boot 10
  done

  echo "(done)" >&3
}

android_studio
