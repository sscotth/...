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
        - "NTP time setup"                      retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/ntp_time_setup.sh

        - "Homebrew cask"                       retry_command gtimeout --preserve-status 120 ./lib/tasks/homebrew/homebrew_cask.sh
        - "Homebrew zap"                        retry_command gtimeout --preserve-status 120 ./lib/tasks/homebrew/homebrew_zap.sh
        - "Homebrew Quick Atom"                 retry_command gtimeout --preserve-status 300 ./lib/tasks/homebrew/homebrew_quick_atom.sh
        - "Homebrew Quick Python"               retry_command gtimeout --preserve-status 300 ./lib/tasks/homebrew/homebrew_quick_python.sh
        - "Homebrew Quick Ruby"                 retry_command gtimeout --preserve-status 300 ./lib/tasks/homebrew/homebrew_quick_ruby.sh
        - "Homebrew Quick Node Version Manager" retry_command gtimeout --preserve-status 300 ./lib/tasks/homebrew/homebrew_quick_nvm.sh
        # - "Homebrew bundle"                     retry_command gtimeout --preserve-status 600 ./lib/tasks/homebrew/homebrew_bundle.sh

        - "Clean .DS_Store files"               retry_command gtimeout --preserve-status 300 ./lib/tasks/macos/clean_ds_store.sh
        - "Generate SSH Keys"                   retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/generate_ssh_keys.sh
        # - "Install Hosts file"                  retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/install_hosts_file.sh # Use Gas Mask app
        - "Install macOS updates"               retry_command gtimeout --preserve-status 600 ./lib/tasks/macos/install_macos_updates.sh
        - "Install Oh-My-ZSH"                   retry_command gtimeout --preserve-status 300 ./lib/tasks/macos/install_oh_my_zsh.sh
        - "Install ZSH Syntax Highlighting"     retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/install_zsh_syntax_highlighting.sh
        - "Load .zshrc from Oh-My-ZSH"          retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/load_zshrc_from_oh_my_zsh.sh
        - "Prepare MongoDB"                     retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/mongodb_prepare.sh
        - "Prepare NTFS"                        retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/ntfs_prepare.sh # Except for SIP check, SKIP FOR NOW
        - "Setup assistive devices"             retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/setup_assistive_devices.sh
        - "Setup folders"                       retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/setup_folders.sh
        - "Increate ulimit"                     retry_command gtimeout --preserve-status 120 ./lib/tasks/macos/increase_ulimit.sh

        - "Remove previous Dotfiles"            retry_command gtimeout --preserve-status 120 ./lib/tasks/dotfiles/dotfiles_remove.sh
        - "Mathias Bynens' Dotfiles"            retry_command gtimeout --preserve-status 120 ./lib/tasks/dotfiles/mathiasbynens_dotfiles.sh
        - "Personal Dotfiles"                   retry_command gtimeout --preserve-status 120 ./lib/tasks/dotfiles/personal_dotfiles.sh

        - "Android Studio"                      retry_command gtimeout --preserve-status 600 ./lib/tasks/apps/android-studio.sh
        - "asepsis"                             retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/asepsis.sh # Except for SIP check, SKIP FOR NOW
        - "atom"                                retry_command gtimeout --preserve-status 600 ./lib/tasks/apps/atom.sh
        - "chrome canary"                       retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/chrome-canary.sh
        - "iterm2"                              retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/iterm2.sh
        - "python"                              retry_command gtimeout --preserve-status 600 ./lib/tasks/apps/python.sh
        - "ruby"                                retry_command gtimeout --preserve-status 600 ./lib/tasks/apps/ruby.sh
        - "spoofmac"                            retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/spoofmac.sh
        - "sublime text"                        retry_command gtimeout --preserve-status 120 ./lib/tasks/apps/sublime-text.sh

        - "Install Node.js LTS"                 retry_command gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_lts.sh
        - "Install Node.js LTS Packages"        retry_command gtimeout --preserve-status 300 ./lib/tasks/nodejs/install_node_lts_packages.sh
        - "Install Node.js Stable"              retry_command gtimeout --preserve-status 120 ./lib/tasks/nodejs/install_node_stable.sh
        - "Install Node.js Stable Packages"     retry_command gtimeout --preserve-status 300 ./lib/tasks/nodejs/install_node_stable_packages.sh
        - "Clean npm cache"                     retry_command gtimeout --preserve-status 120 ./lib/tasks/nodejs/clean_npm_cache.sh

        --require "Remove previous Dotfiles"
        --before  "Mathias Bynens' Dotfiles"
        --before  "Personal Dotfiles"

        --require "Install Oh-My-ZSH"
        --before  "Load .zshrc from Oh-My-ZSH"
        --before  "Install ZSH Syntax Highlighting"

        --require "Homebrew cask"
        --before  "Homebrew zap"
        --before  "Homebrew Quick Atom"

        --require "Homebrew Quick Atom"
        --before "Homebrew Quick Python"
        --before "atom"

        --require "Homebrew Quick Python"
        --before "Homebrew Quick Ruby"
        --before "python"

        --require "Homebrew Quick Ruby"
        --before "Homebrew Quick Node Version Manager"
        --before "ruby"

        --require "Homebrew Quick Node Version Manager"
        --before  "Install Node.js Stable"
        --before  "Install Node.js LTS"

        --require "Install Node.js Stable"
        --before  "Install Node.js Stable Packages"

        --require "Install Node.js LTS"
        --before  "Install Node.js LTS Packages"

        --require "Install Node.js Stable Packages"
        --require "Install Node.js LTS Packages"
        --before  "Clean npm cache"

        --require "python"
        --before  "spoofmac"

    )

    concurrent "${args[@]}"
}

concurrent_install
