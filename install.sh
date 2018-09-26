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

    boxecho "Remove Homebrew taps"
    brew untap $(brew tap | grep -v core)

    boxecho "Homebrew Cask"
    brew uninstall --force brew-cask
    brew cask

    boxecho "Updating Homebrew"
    brew update

    boxecho "Homebrew cleanup"
    brew cleanup
fi

boxecho "Homebrew Doctor"
brew doctor

boxecho "Homebrew Cask Doctor"
brew cask doctor

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

# Never dim display during install (needed?)
# cached_sudo pmset force -a displaysleep 0

echo "Disable screensaver"

# Disable screensaver during install
defaults -currentHost write com.apple.screensaver idleTime 0

# echo "==> 'Disabling login screensaver'"
# defaults -currentHost write com.apple.screensaver loginWindowIdleTime 0
# echo "==> 'Turning off energy saving'"
# pmset -a displaysleep 0 disksleep 0 sleep 0
# # https://carlashley.com/2016/10/19/com-apple-touristd/
# echo "==> 'Disable New to Mac notification'"
# defaults write com.apple.touristd seed-https://help.apple.com/osx/mac/10.12/whats-new -date "$(date)"

boxecho "Other concurrent tasks"
bash ./lib/tasks/index.sh


# # Homebrew installs (parallelize) Attempt 3 times (allowing for ctrl-c)
bash ./lib/tasks/osx/homebrew.sh
bash ./lib/tasks/osx/homebrew.sh
bash ./lib/tasks/osx/homebrew.sh

# Bundle Homebrew for missing parallelized homebrew installs
cached_psudo brew bundle

exit 1

# echo "kill affected applications"
# sh kill.sh
