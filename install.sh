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

# Install Homebrew if not installed # < /dev/null to prevent "Press RETURN to continue or any other key to abort"
cached_psudo '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null'

boxecho "Homebrew Doctor"
brew doctor
brew cask doctor

boxecho "Remove Homebrew taps"
brew untap $(brew tap | grep -v core)

boxecho "Homebrew cleanup"
brew cleanup

boxecho "Homebrew Cask"
brew uninstall --force brew-cask
brew cask

boxecho "Homebrew Update"
brew update

boxecho "Coreutils"
brew install coreutils
brew upgrade coreutils

boxecho "Lolcat"
brew install lolcat
brew upgrade lolcat

if [[ -z "${BASH_VERSINFO[@]}" || "${BASH_VERSINFO[0]}" -lt 4 || "${BASH_VERSINFO[1]}" -lt 2 ]]; then
  boxecho "Install Updated Bash"
  brew install bash
  brew upgrade bash

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

boxecho "Homebrew installs (parallelized)"
# Homebrew installs (parallelize) Attempt 3 times (allowing for ctrl-c)
bash ./lib/tasks/osx/homebrew.sh
bash ./lib/tasks/osx/homebrew.sh
bash ./lib/tasks/osx/homebrew.sh

boxecho "Homebrew installs (bundle)"
# Bundle Homebrew for missing parallelized homebrew installs
# brew bundle check
cached_psudo brew bundle --verbose --file=.Brewfile

exit 1

boxecho "Other concurrent tasks"
bash ./lib/tasks/index.sh

# iTerm2 v3 Shell Integration
curl -L https://iterm2.com/misc/install_shell_integration.sh | bash

# Install atom plugins
apm stars --user sscotth --install
yes | apm upgrade

# Sublime Text 3
# Symlink settings
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
ln -fs ~/.dotfiles/SublimeText/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
ln -fs ~/.dotfiles/SublimeText/highlighter.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
# Install Package Control
curl https://packagecontrol.io/Package%20Control.sublime-package > ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package
# symlink requried packages
ln -sf ~/.dotfiles/SublimeText/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

# Install Python apps
# Upgrade pip
pip install --upgrade pip
pip3 install --upgrade pip

# Virtual Environments for Python
pip install --upgrade virtualenv
pip3 install --upgrade virtualenv

pip install --upgrade virtualenvwrapper
pip3 install --upgrade virtualenvwrapper

# Setup directories
mkdir -p ~/code ~/.virtualenvs
WORKON_HOME=~/.virtualenvs
PROJECT_HOME=~/code
VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh
workon

pip install SpoofMAC
# Finish SpoofMAC Install https://github.com/feross/SpoofMAC#startup-installation-instructions
  # Download the startup file for launchd
  curl https://raw.githubusercontent.com/feross/SpoofMAC/master/misc/local.macspoof.plist > /tmp/local.macspoof.plist

  # Customize location of `spoof-mac.py` to match your system
  cat /tmp/local.macspoof.plist | sed "s|/usr/local/bin/spoof-mac.py|`which spoof-mac.py`|" | tee /tmp/local.macspoof.plist

  # Copy file to the OS X launchd folder
  cached_sudo cp /tmp/local.macspoof.plist /Library/LaunchDaemons

  # Set file permissions
  cached_sudo chown root:wheel /Library/LaunchDaemonslocal.macspoof.plist
  cached_sudo chmod 0644 /Library/LaunchDaemonslocal.macspoof.plist

# Install Ruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
ruby-install ruby
chruby ruby
gem install rails
gem install rubocop
gem install travis
gem isntall reek

# Fix asepsis failed update notifications
asepsisctl uninstall_updater

# echo "kill affected applications"
# sh kill.sh
