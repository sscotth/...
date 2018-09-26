#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh
source ./lib/utilities.sh


concurrent_install () {
    local CONCURRENT_LIMIT=8
    local CONCURRENT_COMPACT=-1
    local CONCURRENT_NONINTERACTIVE=1

    local args=()

    echo "SETTING UP BREW TAPS FOR BASH CONCURRENT"

    local brew_taps=($(cat .Brewfile | grep "^tap" | sed "s/tap //g;s/'//g"))
    # sed "s/tap \|'//g"
    echo ${brew_taps[*]}

    for tap in "${brew_taps[@]}"; do
      args=( "${args[@]}" - "BREW TAP $tap" cached_psudo "lib/retry.sh gtimeout --preserve-status 120 brew tap $tap")
    done

    # echo ${args[*]}
    printf '%s\n' "${args[@]}"

    echo "SETTING UP BREW INSTALLS FOR BASH CONCURRENT"

    local brew_installs=(`cat .Brewfile | grep "^brew" | sed "s/^brew//g;s/ //g;s/'//g;s/,.*//g"`)
    # sed "s/^brew\| \|'\|,.*//g"
    echo "BREW LIST: ${brew_installs[*]}"

    for brew in "${brew_installs[@]}"; do
      local cmd=`cat .Brewfile | grep "^brew '${brew}'" | sed "s/',[^']*/ --/g" | sed "s/'//g;s/]//g;" | sed "s/^brew/brew install/g"`
      # sed "s/'\|]//g" | sed "s/^brew/brew info/g"`
      args=( "${args[@]}" - "BREW INSTALL $brew" cached_psudo "lib/retry.sh gtimeout --preserve-status 120 $cmd")
    done

    printf '%s\n' "${args[@]}"

    echo "SETTING UP CASK INSTALLS FOR BASH CONCURRENT"

    local cask_installs=(`cat .Brewfile | grep "^cask" | sed "s/^cask//g;s/ //g;s/'//g"`) # sed "s/^cask \|'//g"`)
    echo "CASK LIST: ${cask_installs[*]}"

    for cask in "${cask_installs[@]}"; do
      args=("${args[@]}" - "CASK INSTALL $cask" cached_psudo "lib/retry.sh gtimeout --preserve-status 120 brew cask install $cask")
    done

    printf '%s\n' "${args[@]}"

    # echo "SETTING UP BREW TAP REQUIREMENTS BEFORE INSTALL FOR BASH CONCURRENT"
    #
    # for brew in "${brew_installs[@]}"; do
    #   for tap in "${brew_taps[@]}"; do
    #     args=("${args[@]}" --require "BREW TAP $tap")
    #   done
    #
    #   args=("${args[@]}" --before "BREW INSTALL $brew")
    # done
    #
    # printf '%s\n' "${args[@]}"
    #
    # echo "SETTING UP BREW TAP REQUIREMENTS BEFORE INSTALL FOR BASH CONCURRENT"
    #
    # for cask in "${cask_installs[@]}"; do
    #   args=("${args[@]}" --require "BREW TAP homebrew/cask" --before "CASK INSTALL $cask")
    # done
    #
    # printf '%s\n' "${args[@]}"
    #
    args=("${args[@]}"
      --require "CASK INSTALL osxfuse"
      --before "BREW INSTALL ntfs-3g"
      --before "BREW INSTALL sshfs"
    )

    concurrent "${args[@]}"
}

concurrent_install
