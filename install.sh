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
while true; do sudo -n true; sleep 600; kill -0 "$$" || exit; done 2>/dev/null &

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
for file in $(find . -name '.*' ! -name '.' ! -name '.git' ! -name '.gitignore' ! -path '*math_dotfiles*'); do
  src="$(pwd)/$(basename $file)"
  dst="$HOME/$(basename $file)"

  echo "$src ==> $dst"
  ln -sf "$src" "$dst"
done

# load_osx_defaults
echo "Loading osx preferences. Note that some of these changes require a logout/restart to take effect."

echo "loading mathiasbynens' sensible hacker defaults"
cd math_dotfiles
sh /tmp/.osx_nokill
cd ..

echo "loading personal osx preferences"
sh osx_supplement

# Install Oh-My-ZSH
echo "Installing Oh-My-Zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o /tmp/omz-install.sh

# remove changing of shell actions from omz-install script
sed -E '/.*(chsh -s|env zsh)/d' /tmp/omz-install.sh > /tmp/omz-install-nochsh.sh

# sh /tmp/omz-install.sh
sh /tmp/omz-install-nochsh.sh

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
sh brew.sh

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
