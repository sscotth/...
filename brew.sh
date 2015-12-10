#!/bin/sh

# TAPS
brew tap homebrew/dupes
brew tap homebrew/fuse
brew tap homebrew/science

brew tap caskroom/versions
brew tap caskroom/fonts

brew tap neovim/neovim

# Casks symlink in applications folder
ln -sf /opt/homebrew-cask/Caskroom /Applications/Caskroom

# Make sure up to date
brew update
brew doctor
brew upgrade --all

# Fetch Brews
cat ~/.dotfiles/Brewfile | grep 'brew install' | sed 's/^brew install //' | sed -e 's/ .*$//' | parallel --bar -j3 \
  "brew fetch {}"

# Install Brews
cat ~/.dotfiles/Brewfile | grep 'brew install' | parallel --bar -j1 \
  "echo {}; sudo xcodebuild -license accept &> /dev/null; eval {}" &

# Fetch and install Casks
cat ~/.dotfiles/Caskfile | grep 'brew cask' | parallel --bar -j3 \
  "echo {}; eval {}" &

wait

# Cleanup
brew cleanup -s
brew cask cleanup
