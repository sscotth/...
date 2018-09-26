#!/usr/bin/env bash

source ./lib/utilities.sh

if [[ -z "${BASH_VERSINFO[@]}" || "${BASH_VERSINFO[0]}" -lt 4 || "${BASH_VERSINFO[1]}" -lt 2 ]]; then
  boxecho "Requires Bash version 4.2 (you have ${BASH_VERSION:-a different shell})"
  boxecho "Attempting to install. Script will attmpet to restart itself. Otherwise, reload terminal when finished and try again"
fi

  boxecho "Enter passwords upfront to continue"

if [ -z ${APPLE_ID_PASSWORD+x} ]; then
  read -s -p "Apple ID Password:" APPLE_ID_PASSWORD
  export APPLE_ID_PASSWORD=$APPLE_ID_PASSWORD
  echo ''
fi

cached_sudo -v

boxecho "Homebrew"


if [[ $(command -v brew) == "" ]]; then
    boxecho "Installing Hombrew"
    # < /dev/null to prevent "Press RETURN to continue or any other key to abort"
    cached_psudo '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null'
else
  boxecho "Updating Homebrew"
  brew update
fi

boxecho "Homebrew Doctor"
brew doctor

boxecho "Coreutils"
brew install coreutils

boxecho "Lolcat"
brew install lolcat

if [[ -z "${BASH_VERSINFO[@]}" || "${BASH_VERSINFO[0]}" -lt 4 || "${BASH_VERSINFO[1]}" -lt 2 ]]; then
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

# (Re-)Download my fork of bash-concurrent (https://github.com/themattrix/bash-concurrent) and use nocompact branch
rm -rf bash-concurrent
git clone https://github.com/sscotth/bash-concurrent
cd bash-concurrent
git checkout nocompact
cd ..

boxecho "Disable energy saving features during install"

echo "Never go into computer sleep mode"

# Never go into computer sleep mode during install
  # Usage: systemsetup -setcomputersleep <minutes>
	# Set amount of idle time until compputer sleeps to <minutes>.
	# Specify "Never" or "Off" for never.

cached_sudo systemsetup -setcomputersleep Off

cached_sudo pmset -a displaysleep 0

# pmset -a displaysleep 0 disksleep 0 sleep 0

# Never dim display during install (needed?)
# cached_sudo pmset force -a displaysleep 0

echo "Disable screensaver"

# Disable screensaver during install
defaults -currentHost write com.apple.screensaver idleTime 0

boxecho "Other concurrent tasks"
bash ./lib/tasks/index.sh

boxecho "Homebrew bundle" # 3 more times to allow for ctrl-c in case of stall
cached_psudo brew bundle --file=.Brewfile
cached_psudo brew bundle --file=.Brewfile
cached_psudo brew bundle --file=.Brewfile

boxecho "Homebrew cleanup"
brew cleanup -s
rm -rf "$(brew --cache)"

boxecho "Load macOS defaults. RESTART WHEN FINISHED."

tput bel
sleep 1
afplay /System/Library/Sounds/Ping.aiff
sleep 1
say "Are you ready?"

read -p "Are you ready? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

cached_psudo lib/tasks/macos/load_macos_defaults.sh

# Apps that still need to be activated for new installs
#
# Teamviewer for unattended
