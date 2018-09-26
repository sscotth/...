#!/usr/bin/env bash

homebrew () {
  echo "Homebrew installs (parallelized)"
  bash ./lib/tasks/osx/homebrew.sh
}

homebrew
