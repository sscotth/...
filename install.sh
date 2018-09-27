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

boxecho "Coreutils"
brew install coreutils

boxecho "Lolcat"
brew install lolcat

boxecho "mas-cli"

mas_cli_signin

boxecho "Bash v4.2+"

if [[ -z "${BASH_VERSINFO[@]}" || "${BASH_VERSINFO[0]}" -lt 4 || "${BASH_VERSINFO[1]}" -lt 2 ]]; then
  boxecho "Requires Bash version 4.2 (you have ${BASH_VERSION:-a different shell})"
  boxecho "Attempting to install. Script will attmpet to restart itself. Otherwise, reload terminal when finished and try again"
  boxecho "Install Updated Bash"
  brew install bash

  # In order to use this build of bash as your login shell, it must be added to /etc/shells.

  if cat /etc/shells | grep /usr/local/bin/bash &> /dev/null; then
    boxecho "Add Homebrew's bash to available shells"

    # Requires subshell
    # sudo echo /usr/local/bin/bash >> /etc/shells
    # -bash: /etc/shells: Permission denied

    cached_sudo 'bash -c "echo /usr/local/bin/bash >> /etc/shells"'
  fi

  boxecho "Change default shell to Homebrew bash"
  # could use cached_psudo here, but password request is slightly different than normal sudo "Password for scott: "
  cached_sudo chsh -s /usr/local/bin/bash $(whoami)

  boxecho "Attempting to reload shell"
  exec bash --login -c "./install.sh"

  # If you reach this line, the reload failed
  boxecho "Reload Failed. Reload terminal and try again."
  exit 1
fi

boxecho "BASH v4.2+ INSTALLED - BEGIN INSTALLATION"

boxecho "Bash-Concurrent"

# Switch to zsh
# cached_sudo chsh -s $(which zsh) scott

# (Re-)Download my fork of bash-concurrent and use nocompact branch
rm -rf bash-concurrent
# git clone https://github.com/themattrix/bash-concurrent/
git clone https://github.com/sscotth/bash-concurrent
cd bash-concurrent
git checkout nocompact
cd ..

boxecho "Concurrent tasks (Restart if this fails instantly)"
bash ./lib/tasks/index.sh || true

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
say "Are you ready?"

# https://stackoverflow.com/a/1885534
read -p "Are you ready? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

cached_psudo lib/tasks/macos/load_macos_defaults.sh

# Apps that still need to be activated for new installs
#
# Teamviewer for unattended
