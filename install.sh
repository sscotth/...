#!/usr/bin/env bash

set -Eeou pipefail
# -E listens for ERR Traps
# -e exit immediately when a command fails. Use command || true to exempt
# -o pipefail sets the exit code of a pipeline to that of the rightmost command to exit with a non-zero status
# -u treat unset variables as an error and exit immediately. Prefer ${VAR:-$DEFAULT} or ${MY_VAR:-} if you don't want a default value.
# -x print each command before executing it.

source ./lib/utilities.sh

cached_sudo -v

boxecho "Homebrew"

if command_exists brew; then
  boxecho "Updating Homebrew"
  brew update
else
  boxecho "Installing Hombrew"
  # < /dev/null to prevent "Press RETURN to continue or any other key to abort"
  cached_psudo '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null'
fi

boxecho "Homebrew Doctor"
brew doctor || true

boxecho "Lolcat"
brew_install_or_upgrade lolcat

boxecho "mas-cli"
brew_install_or_upgrade mas

boxecho "mas-cli signin"
mas_cli_signin

boxecho "Bash v4.2+"
brew_install_or_upgrade bash

boxecho "Zsh"
brew_install_or_upgrade zsh

boxecho "coreutils"
brew_install_or_upgrade coreutils

boxecho "Bash-Concurrent"
# (Re-)Download my fork of bash-concurrent and use nocompact branch
rm -rf bash-concurrent
# git clone https://github.com/themattrix/bash-concurrent/
# git clone https://github.com/sscotth/bash-concurrent
git_clone_or_pull https://github.com/sscotth/bash-concurrent
git -C ./bash-concurrent checkout nocompact

boxecho "Concurrent tasks (Restart if this fails instantly)"
/usr/local/bin/bash ./lib/tasks/index.sh || true

tput bel
sleep 1
afplay /System/Library/Sounds/Ping.aiff
sleep 1
boxecho "Sleep 30 (Restart if prior command failed instantly)"
say "sleep 30"
sleep 30

boxecho "Homebrew bundle" # 3 more times to allow for ctrl-c in case of stall
cached_psudo brew bundle --file=.Brewfile || true
cached_psudo brew bundle --file=.Brewfile || true
cached_psudo brew bundle --file=.Brewfile || true

boxecho "Additional Homebrew fonts"
brew search /nerd-font-mono/ | grep font | xargs brew cask install

boxecho "Cask upgrade details"
yes n | brew cu --no-brew-update && echo

echo
boxecho "Homebrew cleanup"
brew cleanup -s
cached_sudo rm -rf "$(brew --cache)"

boxecho "Load macOS defaults. RESTART WHEN FINISHED."

tput bel
sleep 1
afplay /System/Library/Sounds/Ping.aiff
sleep 1
say "Are you ready? System will restart once finished."

# https://stackoverflow.com/a/1885534
read -p "Are you ready? System will restart once finished. " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

cached_psudo lib/tasks/macos/load_macos_defaults.sh

cached_sudo reboot

# Apps that still need to be activated for new installs
#
# Teamviewer for unattended
