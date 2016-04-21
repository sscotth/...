#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh

for file in $(find './lib/tasks' -name '*.sh'); do
  source $file
done

concurrent_install () {
    local args=(
        - "Use NTP pool servers"                use_ntp_pool_servers
        - "Install OSX updates"                 install_osx_updates
        - "Load Mathias Bynens' Dotfiles"       mathiasbynens_dotfiles_load
        - "Symlink Mathias Bynens' Dotfiles"    mathiasbynens_dotfiles_symlink
        - "Load Personal Dotfiles"              personal_dotfiles_load
        - "Symlink Personal Dotfiles"           personal_dotfiles_symlink
        - "Generate SSH Keys"                   generate_ssh_keys
        - "Install Oh-My-ZSH"                   install_oh_my_zsh
        - "Load .zshrc from Oh-My-ZSH"          load_zshrc_from_oh_my_zsh
        - "Install ZSH Syntax Highlighting"     install_zsh_syntax_highlighting
        - "Install Node.js Version Manager"     install_node_version_manager
        - "Install Node.js Stable"              install_node_stable
        - "Install Node.js Stable Packages"     install_node_stable_packages
        - "Setup Node.js Stable"                setup_node_stable
        - "Install Node.js LTS"                 install_node_lts
        - "Install Node.js LTS Packages"        install_node_lts_packages
        - "Setup Node.js LTS"                   setup_node_lts
        - "Clean npm cache"                     clean_npm_cache
        - "Clean .DS_Store files"               clean_DS_Store
        - "Setup assistive devices"             setup_assistive_devices
        - "Install App Store apps"              install_app_store_apps
        - "Load OSX Settings"                   load_osx_defaults
        - "Prepare MongoDB"                     mongodb_prepare
        - "Prepare NTFS"                        ntfs_prepare

        --require "Load Mathias Bynens' Dotfiles"
        --before  "Symlink Mathias Bynens' Dotfiles"

        --require "Load Personal Dotfiles"
        --before  "Symlink Personal Dotfiles"

        --require "Install Oh-My-ZSH"
        --before  "Load .zshrc from Oh-My-ZSH"
        --before  "Install ZSH Syntax Highlighting"

        --require "Install Node.js Version Manager"
        --before  "Install Node.js Stable"
        --before  "Install Node.js LTS"

        --require "Install Node.js Stable"
        --before  "Install Node.js Stable Packages"
        --before  "Setup Node.js Stable"

        --require "Install Node.js LTS"
        --before  "Install Node.js LTS Packages"
        --before  "Setup Node.js LTS"

        --require "Install Node.js Stable Packages"
        --require "Install Node.js LTS Packages"
        --before  "Clean npm cache"

        --require "Setup assistive devices"
        --before  "Install App Store apps"

        --require "Load Mathias Bynens' Dotfiles"
        --before  "Load OSX Settings"
    )

    concurrent "${args[@]}"
}

# nesting_success() {
#     local args=(
#         - "Task A1"               my_sleep 2.0
#         - "Task A2"               concurrent
#             -- "Task B1"          concurrent
#                 --- "Task C1"     my_sleep 1.0
#                 --- "Task C2"     my_sleep 2.0
#             -- "Task B2"          my_sleep 3.0
#         - "Task A3"               my_sleep 4.0
#     )
#
#     concurrent "${args[@]}"
# }
