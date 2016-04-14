#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh

for file in $(find './lib/tasks' -name '*.sh'); do
  source $file
done

concurrent_install () {
    local args=(
        - "Install OSX updates"                 install_osx_updates                1.0
        - "Loading Mathias Bynens' Dotfiles"    mathiasbynens_dotfiles_load        1.0
        - "Symlink Mathias Bynens' Dotfiles"    mathiasbynens_dotfiles_symlink     1.0
        - "Loading Personal Dotfiles"           personal_dotfiles_load             1.0
        - "Symlink Personal Dotfiles"           personal_dotfiles_symlink          1.0
        - "Generate SSH Keys"                   generate_ssh_keys                  1.0
        - "Install Oh-My-ZSH"                   install_oh_my_zsh                  1.0
        - "Load .zshrc from Oh-My-ZSH"          load_zshrc_from_oh_my_zsh          1.0
        - "Install ZSH Syntax Highlighting"     install_zsh_syntax_highlighting    1.0
        - "Install Node.js Version Manager"     install_node_version_manager       1.0
        - "Install Node.js Stable"              install_node_stable                1.0
        - "Install Node.js Stable Packages"     install_node_stable_packages       1.0
        - "Setup Node.js Stable"                setup_node_stable                  1.0
        - "Install Node.js LTS"                 install_node_lts                   1.0
        - "Install Node.js LTS Packages"        install_node_lts_packages          1.0
        - "Setup Node.js LTS"                   setup_node_lts                     1.0
        - "Clean npm cache"                     clean_npm_cache                    1.0
        - "Clean .DS_Store files"               clean_DS_Store                     1.0
        - "Setup assistive devices"             setup_assistive_devices            1.0
        - "A Function"                          fn_1                               1.0
        - "Another Function"                    fn_2                               1.0

        --require "Loading Mathias Bynens' Dotfiles"
        --before  "Symlink Mathias Bynens' Dotfiles"

        --require "Loading Personal Dotfiles"
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
