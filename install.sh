#!/usr/bin/env bash

if [[ -z "${BASH_VERSINFO[@]}" || "${BASH_VERSINFO[0]}" -lt 4 || "${BASH_VERSINFO[1]}" -lt 2 ]]; then
  echo "Requires Bash version 4.2 (you have ${BASH_VERSION:-a different shell})"
  echo "Attempting to install. Script will attmpet to restart itself. Otherwise, reload terminal when finished and try again"
fi

echo "Enter passwords upfront to continue"
if [ -z ${APPLE_ID_PASSWORD+x} ]; then
  read -s -p "Apple ID Password:" APPLE_ID_PASSWORD
  export APPLE_ID_PASSWORD=$APPLE_ID_PASSWORD
  echo ''
fi

if [ -z ${SUDOPASS+x} ]; then
  read -s -p "SUDO Password:" SUDOPASS
  export SUDOPASS=$SUDOPASS
  echo ''

  /usr/bin/expect <<EOD
  set timeout 999
  spawn sudo -v
  expect "Password:"
  send "$SUDOPASS\n"
  expect eof
EOD
fi

sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 6000; kill -0 "$$" || exit; done 2>/dev/null &

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null

# Never dim display
sudo pmset force -a displaysleep 0

# Disable screensaver
defaults -currentHost write com.apple.screensaver idleTime 0

echo "Install Homebrew if not installed"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null

echo "Run Homebrew Doctor"
brew doctor

echo "Update Homebrew"
brew update

if [[ -z "${BASH_VERSINFO[@]}" || "${BASH_VERSINFO[0]}" -lt 4 || "${BASH_VERSINFO[1]}" -lt 2 ]]; then
  echo "Install Updated Bash"
  brew install bash
  brew upgrade bash

  if cat /etc/shells | grep /usr/local/bin/bash &> /dev/null; then
    echo "Add Homebrew's bash to available shells"

    /usr/bin/expect <<EOD
    set timeout 999
    spawn sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"
    expect "Password:"
    send "$SUDOPASS\n"
    expect eof
EOD
  fi

  echo "Change default shell to Homebrew bash"
  /usr/bin/expect <<EOD
    set timeout 999
    spawn sudo chsh -s /usr/local/bin/bash $(whoami)
    expect "Password:"
    send "$SUDOPASS\n"
    expect eof
EOD

  echo "Attempting to reload shell"
  exec bash --login -c "./install.sh"

  # Reload failed
  echo "Reload Failed. Reload terminal and try again."
  exit 1
fi

echo "Requires Bash version 4.2 (you have ${BASH_VERSION:-a different shell})"

# Switch to zsh
echo "Change default shell to zsh"
/usr/bin/expect <<EOD
set timeout 999
spawn sudo -v
expect "Password:"
send "$SUDOPASS\n"
expect eof
EOD

# /usr/bin/expect <<EOD
#   set timeout 999
#   spawn sudo chsh -s /usr/local/bin/bash $(whoami)
#   expect "Password:"
#   send "$SUDOPASS\n"
#   expect eof
# EOD

sudo chsh -s $(which zsh) scott

# Run concurrent test

# Download concurrent (prefer git)
git clone https://github.com/themattrix/bash-concurrent

# Load concurrent tasks
source ./lib/tasks.sh
concurrent_install

echo "Concurrent Tasks Complete"

exit 1

# Install all available updates
echo "Update OSX in background"
sudo softwareupdate -iva &> /dev/null &

# remove kill affected applicaitons at end of mathiasbynens .osx script
sed '/^# Kill affected applications/,$d' math_dotfiles/.osx > /tmp/.osx_nokill

# load_osx_defaults
echo "Loading osx preferences. Note that some of these changes require a logout/restart to take effect."

echo "loading mathiasbynens' sensible hacker defaults"
cd math_dotfiles
yes | sh /tmp/.osx_nokill
cd ..

echo "loading personal osx preferences"
sh .osx_supplement

echo Adding Terminal to assistive devices
brew install tccutil
/usr/bin/expect <<EOD
set timeout 999
spawn sudo tccutil -i com.apple.Terminal
expect "Password:"
send "$SUDOPASS\n"
expect eof
EOD

echo Installing App Store apps
osascript -l JavaScript appstore.js

echo Installing Homebrew Cask
brew tap caskroom/cask
/usr/bin/expect <<EOD
set timeout 999
spawn brew cask install atom
expect "Password:"
send "$SUDOPASS\n"
expect eof
EOD

# Homebrew installs (parallelize)
brew install parallel
sh brew.sh

# iTerm2 v3 Shell Integration
curl -L https://iterm2.com/misc/install_shell_integration.sh | bash

# Install NVM / Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
. ~/.nvm/nvm.sh

NVM_SYMLINK_CURRENT=true

if nvm which node &> /dev/null; then
  nvm install stable --reinstall-packages-from=node
else
  nvm install node
fi
nvm alias default node
npm install -g npm

if nvm which v4 &> /dev/null; then
  nvm install v4 --reinstall-packages-from=v4
else
  nvm install v4
fi
npm install -g npm
nvm alias lts v4

nvm use node

npm config set init-author-name "Scott Humphries"
npm config set init-author-email "npm@sscotth.io"
npm config set init-author-url "https://sscotth.io"
npm config set init-license "MIT"

# https://github.com/npm/npm/issues/11283
npm config set progress false

npm cache clean

npm install -g babel-eslint
npm install -g bower
npm install -g cordova
npm install -g diff-so-fancy
npm install -g eslint
npm install -g grunt-cli
npm install -g gulp
npm install -g http-server
npm install -g ionic
npm install -g jshint
npm install -g pm2
npm install -g semistandard
npm install -g semistandard-format

npm cache clean

# Install atom plugins
apm stars --user sscotth --install
yes | apm upgrade

# Sublime Text 3
# Symlink settings
ln -fs ~/.dotfiles/SublimeText/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
# Install Package Control
curl https://packagecontrol.io/Package%20Control.sublime-package > ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package
# symlink requried packages
ln -sf ~/.dotfiles/SublimeText/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings

# Install Python apps
# Upgrade pip
pip install --upgrade pip

# Virtual Environments for Python
pip install virtualenv
pip install virtualenvwrapper

# Setup directories
mkdir -p ~/code ~/.virtualenvs
WORKON_HOME=~/.virtualenvs
PROJECT_HOME=~/code
VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh
workon

~/anaconda3/bin/conda update conda -y

pip install SpoofMAC
# Finish SpoofMAC Install https://github.com/feross/SpoofMAC#startup-installation-instructions
  # Download the startup file for launchd
  curl https://raw.githubusercontent.com/feross/SpoofMAC/master/misc/local.macspoof.plist > /tmp/local.macspoof.plist

  # Customize location of `spoof-mac.py` to match your system
  cat /tmp/local.macspoof.plist | sed "s|/usr/local/bin/spoof-mac.py|`which spoof-mac.py`|" | tee /tmp/local.macspoof.plist

  # Copy file to the OS X launchd folder
  sudo cp /tmp/local.macspoof.plist /Library/LaunchDaemons

  # Set file permissions
  sudo chown root:wheel /Library/LaunchDaemonslocal.macspoof.plist
  sudo chmod 0644 /Library/LaunchDaemonslocal.macspoof.plist

# Install Ruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
ruby-install ruby
chruby ruby
gem install rails
gem install rubocop
gem isntall reek

# MongoDB
sudo mkdir -p /data/db
sudo chown -R `whoami` /data

# NTFS-3G
if [ -f /sbin/mount_ntfs ]; then
  sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.original
fi
sudo ln -sf /usr/local/sbin/mount_ntfs /sbin/mount_ntfs

# Fix asepsis failed update notifications
asepsisctl uninstall_updater

# Set random computer name
sudo scutil --set ComputerName `openssl rand -hex 16`
sudo scutil --set LocalHostName `openssl rand -hex 16`
sudo scutil --set HostName `openssl rand -hex 16`

# Install all available updates again before killing applications
# sudo softwareupdate -iva

# clean .DS_Store files
echo "clean .DS_Store files"
clean_DS_Store () {
  sudo find / -name ".DS_Store" -depth -exec rm {} \;
  # find . -type f -name '*.DS_Store' -ls -delete
}
clean_DS_Store

# echo "kill affected applications"
# sh kill.sh
