#!/usr/bin/env bash

# Ask for passwords upfront
read -s -p "Apple ID Password:" APPLE_ID_PASSWORD
export APPLE_ID_PASSWORD=$APPLE_ID_PASSWORD
echo ''

read -s -p "SUDO Password:" SUDOPASS
echo ''

/usr/bin/expect <<EOD
set timeout 999
spawn sudo -v
expect "Password:"
send "$SUDOPASS\n"
expect eof
EOD

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 6000; kill -0 "$$" || exit; done 2>/dev/null &

# Switch to zsh
sudo chsh -s $(which zsh) scott

# Install all available updates
echo "Update OSX in background"
sudo softwareupdate -iva &> /dev/null &

if ! xcode-select -p &> /dev/null; then
    echo 'Install Xcode command line tools'
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    PROD=$(softwareupdate -l |
      grep "\*.*Command Line" |
      head -n 1 | awk -F"*" '{print $2}' |
      sed -e 's/^ *//' |
      tr -d '\n')
    softwareupdate -i "$PROD" -v;

    # echo 'Installing Xcode Command Line Tools. Click "Install" and "Agree"'
    # xcode-select --install &> /dev/null
    #
    # # Wait until the XCode Command Line Tools are installed
    # while ! xcode-select -p &> /dev/null; do
    #     sleep 5
    # done
    # echo 'Installed XCode Command Line Tools'
    #
    # # Point the `xcode-select` developer directory to the appropriate directory from within `Xcode.app` ?????
    # # https://github.com/alrra/dotfiles/issues/13
    # echo 'Make "xcode-select" developer directory point to Xcode'
    # sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    #
    # # Prompt user to agree to the terms of the Xcode license
    # # https://github.com/alrra/dotfiles/issues/10
    # echo 'Agree with the XCode Command Line Tools licence'
    # sudo xcodebuild -license
fi

# Git Setup
GIT_EMAIL_DOMAIN="sscotth.io"
GIT_AUTHOR_NAME="Scott Humphries"
GIT_AUTHOR_EMAIL=git@$GIT_EMAIL_DOMAIN
GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

git config --global user.name $GIT_AUTHOR_NAME
git config --global user.email $GIT_AUTHOR_EMAIL
git config --global core.editor "atom --wait"
git config --global push.default simple

# Generate SSH Keys
SSH_KEY_PW=""
# Ask for password
# read -s -p "SSH KEYPassword:" SSH_KEY_PW
# echo ""
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 4096 -C "scott@sscotth.io" -N "$ssh_key_pw" -f ~/.ssh/id_rsa
fi
ssh-add ~/.ssh/id_rsa

# download_mathiasbynens_dotfiles
if [ -d "math_dotfiles" ]; then
  cd math_dotfiles
  git pull origin master
  cd ..
else
  git clone --depth 1 https://github.com/mathiasbynens/dotfiles math_dotfiles
fi

# remove kill affected applicaitons at end of mathiasbynens .osx script
sed '/^# Kill affected applications/,$d' math_dotfiles/.osx > /tmp/.osx_nokill

# symlink_selected_mathiasbynens_dotfiles
echo "symlinking selected mathiasbynens dotfiles"
for file in $HOME/.dotfiles/math_dotfiles/.{bashrc,curlrc,gitconfig,hushlogin,inputrc,wgetrc,extra}; do
  dst="$HOME/$(basename $file)"
  [ -r $file ] && [ -f $file ] && echo "$file ==> $dst" && ln -sf $file $dst
done;

# symlink_personal_dotfiles
echo "symlinking personal dotfiles"
ln -sf ~/.gitignore_global ~/.gitignore
for file in $(find . -name '.*' ! -name '.' ! -name '.git' ! -name '.gitignore' ! -name '.zshrc' ! -path '*math_dotfiles*'); do
  src="$(pwd)/$(basename $file)"
  dst="$HOME/$(basename $file)"

  echo "$src ==> $dst"
  ln -sf "$src" "$dst"
done

# load_osx_defaults
echo "Loading osx preferences. Note that some of these changes require a logout/restart to take effect."

echo "loading mathiasbynens' sensible hacker defaults"
cd math_dotfiles
yes | sh /tmp/.osx_nokill
cd ..

echo "loading personal osx preferences"
sh .osx_supplement

# Install Oh-My-ZSH
echo "Installing Oh-My-Zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /tmp/omz-install.sh

# remove changing of shell actions from omz-install script
sed -E '/.*(chsh -s|env zsh)/d' /tmp/omz-install.sh > /tmp/omz-install-nochsh.sh

# sh /tmp/omz-install.sh
sh /tmp/omz-install-nochsh.sh

# make sure .zshrc is fresh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# add .zsh_profile reference to .zshrc
echo 'source ~/.zsh_profile' >> ~/.zshrc

# symlink zshrc back to the .dotfiles repo
# ln -sf ~/.zshrc ~/.dotfiles/.zshrc

# Install Homebrew
echo Installing Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
brew doctor

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
brew install caskroom/cask/brew-cask
/usr/bin/expect <<EOD
set timeout 999
spawn brew cask
expect "Password:"
send "$SUDOPASS\n"
expect eof
EOD

# Homebrew installs
brew install parallel
sh brew.sh

# Install NVM / Node.js
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
. ~/.nvm/nvm.sh

if nvm which node &> /dev/null; then
  nvm install stable --reinstall-packages-from=node
else
  nvm install node
fi
nvm alias default node
npm install -g npm

if nvm which v4.2 &> /dev/null; then
  nvm install v4.2 --reinstall-packages-from=v4.2
else
  nvm install v4.2
fi
npm install -g npm
nvm alias lts v4.2

nvm use node

npm config set init-author-name "Scott Humphries"
npm config set init-author-email "npm@sscotth.io"
npm config set init-author-url "https://sscotth.io"
npm config set init-license "MIT"

npm install -g bower
npm install -g cordova
npm install -g eslint
npm install -g grunt-cli
npm install -g gulp
npm install -g http-server
npm install -g ionic
npm install -g jshint
npm install -g pm2

# Install atom plugins
apm stars --user sscotth --install

# Install Python apps
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

# MongoDB
sudo mkdir -p /data/db
sudo chown -R `whoami` /data

# NTFS-3G
if [ -f /sbin/mount_ntfs ]; then
  sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.original
fi
sudo ln -sf /usr/local/sbin/mount_ntfs /sbin/mount_ntfs

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
