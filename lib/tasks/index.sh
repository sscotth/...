#!/usr/bin/env bash

set -Eeo pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh
source ./lib/utilities.sh

concurrent_install () {
    local CONCURRENT_LIMIT=4
    # local CONCURRENT_COMPACT=1

    local args=(
        - "Disable energy savings"              retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/disable_energy_savings.sh

        - "Homebrew cask"                       retry_command gtimeout --preserve-status 120 ./lib/tasks/homebrew/homebrew_cask.sh
        - "Homebrew zap"                        retry_command gtimeout --preserve-status 120 ./lib/tasks/homebrew/homebrew_zap.sh
        - "Homebrew quick"                      retry_command gtimeout --preserve-status 120 ./lib/tasks/homebrew/homebrew_quick.sh
        # - "Homebrew bundle"                     retry_command gtimeout --preserve-status 600 ./lib/tasks/homebrew/homebrew_bundle.sh

        - "Remove previous Dotfiles"            retry_command gtimeout --preserve-status 120 ./lib/tasks/dotfiles/dotfiles_remove.sh
        - "Mathias Bynens' Dotfiles"            retry_command gtimeout --preserve-status 120 ./lib/tasks/dotfiles/mathiasbynens_dotfiles.sh
        - "Personal Dotfiles"                   retry_command gtimeout --preserve-status 120 ./lib/tasks/dotfiles/personal_dotfiles.sh

        - "Clean .DS_Store files"               retry_command gtimeout --preserve-status 300 ./lib/tasks/macos/clean_ds_store.sh
        - "Generate SSH Keys"                   retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/generate_ssh_keys.sh
        # - "Install Hosts file"                  retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/install_hosts_file.sh # Use Gas Mask app
        - "Install Oh-My-ZSH"                   retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/install_oh_my_zsh.sh
        - "Install macOS updates"               retry_command gtimeout --preserve-status 300 ./lib/tasks/macos/install_macos_updates.sh
        - "Install ZSH Syntax Highlighting"     retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/install_zsh_syntax_highlighting.sh
        - "Load .zshrc from Oh-My-ZSH"          retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/load_zshrc_from_oh_my_zsh.sh

        - "Prepare MongoDB"                     retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/mongodb_prepare.sh
        - "Prepare NTFS"                        retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/ntfs_prepare.sh # Except for SIP check, SKIP FOR NOW
        - "Setup assistive devices"             retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/setup_assistive_devices.sh
        # - "Use NTP pool servers"                retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/use_ntp_pool_servers.sh # Broken in mojave

        - "Install Node.js Version Manager"     retry_command gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_version_manager.sh # BREW
        - "Install Node.js LTS"                 retry_command gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_lts.sh
        - "Install Node.js LTS Packages"        retry_command gtimeout --preserve-status 300 ./lib/tasks/nodejs/install_node_lts_packages.sh
        - "Install Node.js Stable"              retry_command gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_stable.sh
        - "Install Node.js Stable Packages"     retry_command gtimeout --preserve-status 300 ./lib/tasks/nodejs/install_node_stable_packages.sh
        - "Clean npm cache"                     retry_command gtimeout --preserve-status 120 ./lib/tasks/nodejs/clean_npm_cache.sh

        - "iterm2"                              retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/iterm2.sh
        - "atom"                                retry_command gtimeout --preserve-status 600 ./lib/tasks/apps/atom.sh
        - "python"                              retry_command gtimeout --preserve-status 600 ./lib/tasks/apps/python.sh
        - "ruby"                                retry_command gtimeout --preserve-status 600 ./lib/tasks/apps/ruby.sh
        - "sublime text"                        retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/sublime-text.sh
        - "spoofmac"                            retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/spoofmac.sh
        - "asepsis"                             retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/asepsis.sh # Except for SIP check, SKIP FOR NOW

        --require "Remove previous Dotfiles"
        --before  "Mathias Bynens' Dotfiles"
        --before  "Personal Dotfiles"

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

        --require "Homebrew cask"
        --before  "Homebrew zap"
        --before  "Homebrew quick"

        # --require "Install Node.js Version Manager"
        # --require "Homebrew zap"
        # --require "Homebrew quick"
        # --before  "Homebrew bundle"

        --require "Homebrew quick"
        --before  "atom"
        --before  "python"
        --before  "ruby"
        --before  "sublime text"

        --require "python"
        --before  "spoofmac"

    )

    concurrent "${args[@]}"
}

concurrent_install
