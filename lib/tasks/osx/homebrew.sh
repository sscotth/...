#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh
source ./lib/utilities.sh

# brew cask setup
brew uninstall --force brew-cask || true
brew untap $(brew tap | grep -v core) || true
brew update || true
brew cleanup || true
brew cask cleanup || true
brew cask doctor || true

# install  example cask app to trigger sudo
brew cask install alfred

concurrent_install () {
    local CONCURRENT_LIMIT=4
    local CONCURRENT_COMPACT=0

    local args=()

    local brew_taps=(`cat .Brewfile | grep "^tap" | sed "s/tap //g;s/'//g" | sed ""`)
    # sed "s/tap \|'//g"
    for tap in "${brew_taps[@]}"; do
      args=( "${args[@]}"
          - "brew tap $tap" brew tap $tap
      )
    done

    local brew_installs=(`cat .Brewfile | grep "^brew" | sed "s/^brew//g;s/ //g;s/'//g;s/,.*//g"`)
    # sed "s/^brew\| \|'\|,.*//g"
    for brew in "${brew_installs[@]}"; do
      local cmd=`cat .Brewfile | grep "^brew '${brew}'" | sed "s/',[^']*/ --/g" | sed "s/'//g;s/]//g;" | sed "s/^brew/brew install/g"`
      # sed "s/'\|]//g" | sed "s/^brew/brew info/g"`
      args=( "${args[@]}"
          - "brew install $brew" $cmd
      )
    done

    local cask_installs=(`cat .Brewfile | grep "^cask" | sed "s/^cask \|'//g"`)
    for cask in "${cask_installs[@]}"; do
      args=("${args[@]}" - "brew cask install $cask" brew cask install $cask)
    done

    for brew in "${brew_installs[@]}"; do
      for tap in "${brew_taps[@]}"; do
        args=("${args[@]}" --require "brew tap $tap")
      done

      args=("${args[@]}" --before "brew install $brew")
    done

    for cask in "${cask_installs[@]}"; do
      for tap in "${brew_taps[@]}"; do
        args=("${args[@]}" --require "brew tap $tap")
      done

      args=("${args[@]}" --before "brew cask install $cask")
    done

    concurrent "${args[@]}"
}

concurrent_install
