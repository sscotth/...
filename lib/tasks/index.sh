#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh
source ./lib/utilities.sh

concurrent_install () {
    local CONCURRENT_LIMIT=4
    local CONCURRENT_COMPACT=1

    local args=(

        # - "Remove previous Dotfiles"            retry gtimeout --preserve-status 120 ./lib/tasks/dotfiles/dotfiles_remove.sh
        # - "Load Mathias Bynens' Dotfiles"       retry gtimeout --preserve-status 120 ./lib/tasks/dotfiles/mathiasbynens_dotfiles_load.sh
        # - "Load Personal Dotfiles"              retry gtimeout --preserve-status 120 ./lib/tasks/dotfiles/personal_dotfiles_load.sh
        # - "Symlink Mathias Bynens' Dotfiles"    retry gtimeout --preserve-status 120 ./lib/tasks/dotfiles/mathiasbynens_dotfiles_symlink.sh
        # - "Symlink Personal Dotfiles"           retry gtimeout --preserve-status 120 ./lib/tasks/dotfiles/personal_dotfiles_symlink.sh

        - "Clean .DS_Store files"               retry gtimeout --preserve-status 300 ./lib/tasks/osx/clean_ds_store.sh
        - "Generate SSH Keys"                   retry gtimeout --preserve-status 120 ./lib/tasks/osx/generate_ssh_keys.sh
        # - "Install Hosts file"                  retry gtimeout --preserve-status 120 ./lib/tasks/osx/install_hosts_file.sh # Use Gas Mask app
        - "Install Oh-My-ZSH"                   retry gtimeout --preserve-status 120 ./lib/tasks/osx/install_oh_my_zsh.sh
        - "Install OSX updates"                 retry gtimeout --preserve-status 300 ./lib/tasks/osx/install_osx_updates.sh
        - "Install ZSH Syntax Highlighting"     retry gtimeout --preserve-status 120 ./lib/tasks/osx/install_zsh_syntax_highlighting.sh
        - "Load .zshrc from Oh-My-ZSH"          retry gtimeout --preserve-status 120 ./lib/tasks/osx/load_zshrc_from_oh_my_zsh.sh
        - "Load OSX Settings"                   retry gtimeout --preserve-status 120 ./lib/tasks/osx/load_osx_defaults.sh
        - "Prepare MongoDB"                     retry gtimeout --preserve-status 120 ./lib/tasks/osx/mongodb_prepare.sh
        - "Prepare NTFS"                        retry gtimeout --preserve-status 120 ./lib/tasks/osx/ntfs_prepare.sh # Except for SIP check, SKIP FOR NOW
        - "Setup assistive devices"             retry gtimeout --preserve-status 120 ./lib/tasks/osx/setup_assistive_devices.sh
        # - "Use NTP pool servers"                retry gtimeout --preserve-status 120 ./lib/tasks/osx/use_ntp_pool_servers.sh # Broken in mojave

        - "Install Node.js Version Manager"     retry gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_version_manager.sh
        - "Install Node.js LTS"                 retry gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_lts.sh
        - "Install Node.js LTS Packages"        retry gtimeout --preserve-status 300 ./lib/tasks/nodejs/install_node_lts_packages.sh
        - "Install Node.js Stable"              retry gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_stable.sh
        - "Install Node.js Stable Packages"     retry gtimeout --preserve-status 300 ./lib/tasks/nodejs/install_node_stable_packages.sh
        - "Clean npm cache"                     retry gtimeout --preserve-status 120 ./lib/tasks/nodejs/clean_npm_cache.sh

        - "iterm2"                              retry gtimeout --preserve-status 120 ./lib/tasks/apps/iterm2.sh
        - "atom"                                retry gtimeout --preserve-status 600 ./lib/tasks/apps/atom.sh
        - "python"                              retry gtimeout --preserve-status 600 ./lib/tasks/apps/python.sh
        - "ruby"                                retry gtimeout --preserve-status 600 ./lib/tasks/apps/ruby.sh
        - "spoofmac"                            retry gtimeout --preserve-status 120 ./lib/tasks/apps/spoofmac.sh
        - "asepsis"                             retry gtimeout --preserve-status 120 ./lib/tasks/apps/asepsis.sh # Except for SIP check, SKIP FOR NOW

        # - "homebrew"                            retry gtimeout --preserve-status 600 ./lib/tasks/homebrew/homebrew.sh
        # - "homebrew bundle"                     retry gtimeout --preserve-status 999 ./lib/tasks/homebrew/homebrew_bundle.sh

        # --require "Remove previous Dotfiles"
        # --before  "Symlink Mathias Bynens' Dotfiles"
        # --before  "Symlink Personal Dotfiles"
        #
        # --require "Load Mathias Bynens' Dotfiles"
        # --before  "Symlink Mathias Bynens' Dotfiles"
        #
        # --require "Load Personal Dotfiles"
        # --before  "Symlink Personal Dotfiles"

        --require "python"
        --before  "spoofmac"

        --require "Install Oh-My-ZSH"
        --before  "Load .zshrc from Oh-My-ZSH"
        --before  "Install ZSH Syntax Highlighting"

        --require "Install Node.js Version Manager"
        --before  "Install Node.js Stable"
        --before  "Install Node.js LTS"

        --require "Install Node.js Stable"
        --before  "Install Node.js Stable Packages"

        --require "Install Node.js LTS"
        --before  "Install Node.js LTS Packages"

        --require "Install Node.js Stable Packages"
        --require "Install Node.js LTS Packages"
        --before  "Clean npm cache"

        # --require "Load Mathias Bynens' Dotfiles"
        # --before  "Load OSX Settings"
    )

    concurrent "${args[@]}"
}

concurrent_install
