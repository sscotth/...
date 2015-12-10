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

#############
### FETCH ###
#############

# cat ~/.dotfiles/Brewfile | grep 'brew install' | parallel --bar -j3 "echo {}; sudo xcodebuild -license accept; eval {}"
# cat ~/.dotfiles/Caskfile | grep 'brew cask' | parallel --bar -j3 "echo {}"

# APPS
brew fetch ack
brew fetch chruby
brew fetch flow
brew fetch htop-osx
brew fetch httpie
brew fetch hub
brew fetch mackup
brew fetch mongodb
brew fetch neovim --HEAD
brew fetch python3
brew fetch r
brew fetch ranger
brew fetch rethinkdb
brew fetch ruby-install --HEAD
brew fetch s3cmd
brew fetch shellcheck
brew fetch syncthing
brew fetch tccutil
brew fetch the_platinum_searcher
brew fetch the_silver_searcher
brew fetch tmux
brew fetch tree
brew fetch watchman
brew fetch z

# CASK APPS
brew cask fetch 1password-beta
brew cask fetch airmail-beta
brew cask fetch alfred
brew cask fetch apache-couchdb
brew cask fetch appcleaner
brew cask fetch atom-beta
brew cask fetch balsamiq-mockups
brew cask fetch bartender
brew cask fetch bettertouchtool
brew cask fetch brackets
brew cask fetch camtasia
brew cask fetch ccleaner
brew cask fetch charles-beta
brew cask fetch codekit
brew cask fetch dropbox-experimental
brew cask fetch epic
brew cask fetch evernote
brew cask fetch fantastical
brew cask fetch filezilla
brew cask fetch firefox
brew cask fetch firefoxdeveloperedition
brew cask fetch flash
brew cask fetch flux
brew cask fetch fontforge
brew cask fetch fontprep
brew cask fetch free-ruler
brew cask fetch genymotion
brew cask fetch gisto
brew cask fetch github-desktop
brew cask fetch gitter
brew cask fetch glueprint
brew cask fetch google-chrome
brew cask fetch google-chrome-canary
brew cask fetch google-drive
brew cask fetch grandperspective
brew cask fetch handbrake
brew cask fetch hyperswitch
brew cask fetch insomniax
brew cask fetch integrity
brew cask fetch istat-menus
brew cask fetch iterm2-beta
brew cask fetch kaleidoscope
brew cask fetch karabiner
brew cask fetch keka
brew cask fetch kismac
brew cask fetch limechat
brew cask fetch liteicon
brew cask fetch livereload
brew cask fetch macaw
brew cask fetch macid
brew cask fetch makemkv
brew cask fetch mamp
brew cask fetch marked
brew cask fetch mongohub
brew cask fetch monodraw
brew cask fetch mplayerx
brew cask fetch mysqlworkbench
brew cask fetch navicat-premium
brew cask fetch ngrok
brew cask fetch obs
brew cask fetch omnifocus
brew cask fetch omnigraffle
brew cask fetch onyx
brew cask fetch parallels-desktop
brew cask fetch paw
brew cask fetch plex-home-theater
brew cask fetch plex-media-server
brew cask fetch postgres
brew cask fetch psequel
brew cask fetch rescuetime
brew cask fetch robofont
brew cask fetch robomongo
brew cask fetch rstudio
brew cask fetch sabnzbd
brew cask fetch screenhero
brew cask fetch scroll-reverser
brew cask fetch sketch-beta
brew cask fetch skype
brew cask fetch slack
brew cask fetch soundflower
brew cask fetch sourcetree
brew cask fetch spectacle
brew cask fetch steam
brew cask fetch sublime-text3
brew cask fetch switchresx
brew cask fetch textexpander
brew cask fetch totalspaces
brew cask fetch tower
brew cask fetch transmission
brew cask fetch twitterrific
brew cask fetch vagrant
brew cask fetch virtualbox
brew cask fetch viscosity
brew cask fetch vlc
brew cask fetch webstorm-eap
brew cask fetch xld
brew cask fetch xtrafinder

# FONTS
brew cask search /powerline/ | grep font | xargs brew cask fetch
brew cask fetch font-hack
brew cask fetch font-monoid

# PW REQUIRED
brew cask fetch airdisplay
brew cask fetch asepsis
brew cask fetch fontforge
brew cask fetch java
brew cask fetch logitech-unifying
brew cask fetch seil
brew cask fetch teamviewer

# CASK APPS
brew cask install 1password-beta
brew cask install airmail-beta
brew cask install alfred
brew cask install apache-couchdb
brew cask install appcleaner
brew cask install atom-beta
brew cask install balsamiq-mockups
brew cask install bartender
brew cask install bettertouchtool
brew cask install brackets
brew cask install camtasia
brew cask install ccleaner
brew cask install charles-beta
brew cask install codekit
brew cask install dropbox-experimental
brew cask install epic
brew cask install evernote
brew cask install fantastical
brew cask install filezilla
brew cask install firefox
brew cask install firefoxdeveloperedition
brew cask install flash
brew cask install flux
brew cask install fontforge # Issue: Manually move to /Applications - #12517
brew cask install fontprep
brew cask install free-ruler
brew cask install genymotion
brew cask install gisto
brew cask install github-desktop
brew cask install gitter
brew cask install glueprint
brew cask install google-chrome-beta
brew cask install google-chrome-canary
brew cask install google-drive
brew cask install grandperspective
brew cask install handbrake
brew cask install hyperswitch
brew cask install insomniax
brew cask install integrity
brew cask install istat-menus
brew cask install iterm2-beta
brew cask install kaleidoscope
brew cask install karabiner
brew cask install keka
brew cask install kismac
brew cask install limechat
brew cask install liteicon
brew cask install livereload
brew cask install macaw
brew cask install macid
brew cask install makemkv
brew cask install mamp
brew cask install marked
brew cask install mongohub
brew cask install monodraw
brew cask install mplayerx
brew cask install mysqlworkbench
brew cask install navicat-premium
brew cask install ngrok
brew cask install obs
brew cask install omnifocus
brew cask install omnigraffle
brew cask install onyx
brew cask install parallels-desktop
brew cask install paw
brew cask install plex-home-theater
brew cask install plex-media-server
brew cask install postgres
brew cask install psequel
brew cask install rescuetime
brew cask install robofont
brew cask install robomongo
brew cask install rstudio
brew cask install sabnzbd
brew cask install screenhero
brew cask install scroll-reverser
brew cask install sketch-beta
brew cask install skype
brew cask install slack
brew cask install soundflower
brew cask install sourcetree
brew cask install spectacle
brew cask install steam
brew cask install sublime-text3
brew cask install switchresx
brew cask install textexpander
brew cask install totalspaces
brew cask install tower
brew cask install transmission
brew cask install twitterrific
brew cask install vagrant
brew cask install virtualbox
brew cask install viscosity
brew cask install vlc
brew cask install webstorm-eap
brew cask install xld
brew cask install xtrafinder

# FONTS
brew cask search /powerline/ | grep font | xargs brew cask install
# font-anonymous-pro-for-powerline
# font-dejavu-sans-mono-for-powerline
# font-droid-sans-mono-for-powerline
# font-fira-mono-for-powerline
# font-inconsolata-dz-for-powerline
# font-inconsolata-for-powerline
# font-inconsolata-g-for-powerline
# font-liberation-mono-for-powerline
# font-meslo-lg-for-powerline
# font-sauce-code-powerline
# font-source-code-pro-for-powerline
# font-ubuntu-mono-powerline

# PW REQUIRED
# brew cask install airdisplay
brew cask install asepsis
brew cask install java
brew cask install logitech-unifying
brew cask install seil
brew cask install teamviewer
brew cask install vagrant

###########
# CLEANUP #
###########
brew cleanup -s
brew cask cleanup
