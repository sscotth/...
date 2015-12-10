#!/bin/sh

# TAPS
brew tap homebrew/dupes
brew tap homebrew/fuse
brew tap homebrew/science

brew tap caskroom/versions
brew tap caskroom/fonts

brew tap neovim/neovim

# CASK
brew fetch caskroom/cask/brew-cask
brew install caskroom/cask/brew-cask

# Casks symlink in applications folder
ln -s /opt/homebrew-cask/Caskroom /Applications/Caskroom

# Make sure up to date
brew update
brew upgrade --all
brew cask update
brew doctor

# Fetch Brews
cat ~/.dotfiles/Brewfile | grep 'brew install' | sed 's/^brew install //' | parallel -j3 "brew fetch {}"

# Install Brews
cat ~/.dotfiles/Brewfile | grep 'brew install' | parallel --bar -j3 "echo {}; sudo xcodebuild -license accept; eval {}" &
# Fetch and install Casks
cat ~/.dotfiles/Caskfile | grep 'brew cask' | parallel --bar -j3 "echo {}" &

wait

# Cleanup
brew cleanup -s
brew cask cleanup
