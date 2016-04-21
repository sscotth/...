#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh
source ./lib/utilities.sh


concurrent_install () {
    local args=(
        - "Use NTP pool servers"                retry timeout 100 ./lib/tasks/osx/use_ntp_pool_servers.sh
        - "Install OSX updates"                 retry timeout 100 ./lib/tasks/osx/install_osx_updates.sh
        - "Load Mathias Bynens' Dotfiles"       retry timeout 100 ./lib/tasks/dotfiles/mathiasbynens_dotfiles_load.sh
        - "Symlink Mathias Bynens' Dotfiles"    retry timeout 100 ./lib/tasks/dotfiles/mathiasbynens_dotfiles_symlink.sh
        - "Load Personal Dotfiles"              retry timeout 100 ./lib/tasks/dotfiles/personal_dotfiles_load.sh
        - "Symlink Personal Dotfiles"           retry timeout 100 ./lib/tasks/dotfiles/personal_dotfiles_symlink.sh
        - "Generate SSH Keys"                   retry timeout 100 ./lib/tasks/osx/generate_ssh_keys.sh
        - "Install Oh-My-ZSH"                   retry timeout 100 ./lib/tasks/osx/install_oh_my_zsh.sh
        - "Load .zshrc from Oh-My-ZSH"          retry timeout 100 ./lib/tasks/osx/load_zshrc_from_oh_my_zsh.sh
        - "Install ZSH Syntax Highlighting"     retry timeout 100 ./lib/tasks/osx/install_zsh_syntax_highlighting.sh
        - "Install Node.js Version Manager"     retry timeout 100 ./lib/tasks/nodejs/install_node_version_manager.sh
        - "Install Node.js Stable"              retry timeout 100 ./lib/tasks/nodejs/install_node_stable.sh
        - "Install Node.js Stable Packages"     retry timeout 600 ./lib/tasks/nodejs/install_node_stable_packages.sh
        - "Setup Node.js Stable"                retry timeout 100 ./lib/tasks/nodejs/setup_node_stable.sh
        - "Install Node.js LTS"                 retry timeout 100 ./lib/tasks/nodejs/install_node_lts.sh
        - "Install Node.js LTS Packages"        retry timeout 600 ./lib/tasks/nodejs/install_node_lts_packages.sh
        - "Setup Node.js LTS"                   retry timeout 100 ./lib/tasks/nodejs/setup_node_lts.sh
        - "Clean npm cache"                     retry timeout 100 ./lib/tasks/nodejs/clean_npm_cache.sh
        - "Clean .DS_Store files"               retry timeout 100 ./lib/tasks/osx/clean_DS_Store.sh
        - "Setup assistive devices"             retry timeout 100 ./lib/tasks/osx/setup_assistive_devices.sh
        - "Install App Store apps"              retry timeout 100 ./lib/tasks/osx/install_app_store_apps.sh
        - "Load OSX Settings"                   retry timeout 100 ./lib/tasks/osx/load_osx_defaults.sh
        - "Prepare MongoDB"                     retry timeout 100 ./lib/tasks/osx/mongodb_prepare.sh
        - "Prepare NTFS"                        retry timeout 100 ./lib/tasks/osx/ntfs_prepare.sh

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
