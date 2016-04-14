#!/usr/bin/env bash

set -e -o pipefail

# source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/concurrent.lib.sh"
source ./bash-concurrent/concurrent.lib.sh

for file in $(find './lib/tasks' -name '*.sh'); do
  source $file
done

concurrent_install () {
    local args=(
        - "Loading Mathias Bynens' Dotfiles"    mathiasbynens_dotfiles_load       1.0
        - "Symlink Mathias Bynens' Dotfiles"    mathiasbynens_dotfiles_symlink    1.0
        - "Loading Personal Dotfiles"           personal_dotfiles_load            1.0
        - "Symlink Personal Dotfiles"           personal_dotfiles_symlink         1.0
        - "Generate SSH Keys"                   generate_ssh_keys                 1.0
        - "Install Oh-My-ZSH"                   install_oh_my_zsh                 1.0
        - "A Function"                          fn_1                              1.0
        - "Another Function"                    fn_2                              1.0

        --require "Loading Mathias Bynens' Dotfiles"
        --before  "Symlink Mathias Bynens' Dotfiles"

        --require "Loading Personal Dotfiles"
        --before  "Symlink Personal Dotfiles"
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
