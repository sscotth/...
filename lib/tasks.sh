#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh
source ./lib/utilities.sh


concurrent_install () {
    local args=(
        - "Use NTP pool servers"                ./lib/tasks/osx/use_ntp_pool_servers.sh
        - "Install OSX updates"                 ./lib/tasks/osx/install_osx_updates.sh
        - "Load Mathias Bynens' Dotfiles"       ./lib/tasks/dotfiles/mathiasbynens_dotfiles_load.sh
        - "Symlink Mathias Bynens' Dotfiles"    ./lib/tasks/dotfiles/mathiasbynens_dotfiles_symlink.sh
        - "Load Personal Dotfiles"              ./lib/tasks/dotfiles/personal_dotfiles_load.sh
        - "Symlink Personal Dotfiles"           ./lib/tasks/dotfiles/personal_dotfiles_symlink.sh
        - "Generate SSH Keys"                   ./lib/tasks/osx/generate_ssh_keys.sh
        - "Install Oh-My-ZSH"                   ./lib/tasks/osx/install_oh_my_zsh.sh
        - "Load .zshrc from Oh-My-ZSH"          ./lib/tasks/osx/load_zshrc_from_oh_my_zsh.sh
        - "Install ZSH Syntax Highlighting"     ./lib/tasks/osx/install_zsh_syntax_highlighting.sh
        - "Install Node.js Version Manager"     ./lib/tasks/nodejs/install_node_version_manager.sh
        - "Install Node.js Stable"              ./lib/tasks/nodejs/install_node_stable.sh
        - "Install Node.js Stable Packages"     ./lib/tasks/nodejs/install_node_stable_packages.sh
        - "Setup Node.js Stable"                ./lib/tasks/nodejs/setup_node_stable.sh
        - "Install Node.js LTS"                 ./lib/tasks/nodejs/install_node_lts.sh
        - "Install Node.js LTS Packages"        ./lib/tasks/nodejs/install_node_lts_packages.sh
        - "Setup Node.js LTS"                   ./lib/tasks/nodejs/setup_node_lts.sh
        - "Clean npm cache"                     ./lib/tasks/nodejs/clean_npm_cache.sh
        - "Clean .DS_Store files"               ./lib/tasks/osx/clean_DS_Store.sh
        - "Setup assistive devices"             ./lib/tasks/osx/setup_assistive_devices.sh
        - "Install App Store apps"              ./lib/tasks/osx/install_app_store_apps.sh
        - "Load OSX Settings"                   ./lib/tasks/osx/load_osx_defaults.sh
        - "Prepare MongoDB"                     ./lib/tasks/osx/mongodb_prepare.sh
        - "Prepare NTFS"                        ./lib/tasks/osx/ntfs_prepare.sh

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
