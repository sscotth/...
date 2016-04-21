#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh
source ./lib/utilities.sh

concurrent_install () {
    local args=(

        - "Load Mathias Bynens' Dotfiles"       retry gtimeout 100 ./lib/tasks/dotfiles/mathiasbynens_dotfiles_load.sh
        - "Load Personal Dotfiles"              retry gtimeout 100 ./lib/tasks/dotfiles/personal_dotfiles_load.sh
        - "Symlink Mathias Bynens' Dotfiles"    retry gtimeout 100 ./lib/tasks/dotfiles/mathiasbynens_dotfiles_symlink.sh
        - "Symlink Personal Dotfiles"           retry gtimeout 100 ./lib/tasks/dotfiles/personal_dotfiles_symlink.sh

        - "Clean .DS_Store files"               retry gtimeout 100 ./lib/tasks/osx/clean_DS_Store.sh
        - "Generate SSH Keys"                   retry gtimeout 100 ./lib/tasks/osx/generate_ssh_keys.sh
        - "Install App Store apps"              retry gtimeout 100 ./lib/tasks/osx/install_app_store_apps.sh
        - "Install Oh-My-ZSH"                   retry gtimeout 100 ./lib/tasks/osx/install_oh_my_zsh.sh
        - "Install OSX updates"                 retry gtimeout 600 ./lib/tasks/osx/install_osx_updates.sh
        - "Install ZSH Syntax Highlighting"     retry gtimeout 100 ./lib/tasks/osx/install_zsh_syntax_highlighting.sh
        - "Load .zshrc from Oh-My-ZSH"          retry gtimeout 100 ./lib/tasks/osx/load_zshrc_from_oh_my_zsh.sh
        - "Load OSX Settings"                   retry gtimeout 100 ./lib/tasks/osx/load_osx_defaults.sh
        - "Prepare MongoDB"                     retry gtimeout 100 ./lib/tasks/osx/mongodb_prepare.sh
        - "Prepare NTFS"                        retry gtimeout 100 ./lib/tasks/osx/ntfs_prepare.sh
        - "Setup assistive devices"             retry gtimeout 100 ./lib/tasks/osx/setup_assistive_devices.sh
        - "Use NTP pool servers"                retry gtimeout 100 ./lib/tasks/osx/use_ntp_pool_servers.sh

        - "Clean npm cache"                     retry gtimeout 100 ./lib/tasks/nodejs/clean_npm_cache.sh
        - "Install Node.js LTS Packages"        retry gtimeout 600 ./lib/tasks/nodejs/install_node_lts_packages.sh
        - "Install Node.js LTS"                 retry gtimeout 100 ./lib/tasks/nodejs/install_node_lts.sh
        - "Install Node.js Stable Packages"     retry gtimeout 600 ./lib/tasks/nodejs/install_node_stable_packages.sh
        - "Install Node.js Stable"              retry gtimeout 100 ./lib/tasks/nodejs/install_node_stable.sh
        - "Install Node.js Version Manager"     retry gtimeout 100 ./lib/tasks/nodejs/install_node_version_manager.sh
        - "Setup Node.js LTS"                   retry gtimeout 100 ./lib/tasks/nodejs/setup_node_lts.sh
        - "Setup Node.js Stable"                retry gtimeout 100 ./lib/tasks/nodejs/setup_node_stable.sh

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
