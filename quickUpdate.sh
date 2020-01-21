#!/bin/sh

export HOMEBREW_CASK_OPTS="--no-quarantine"

brew update && brew upgrade && brew cu -a -y && brew cleanup

load_nvm () {
  export NVM_DIR=~/.nvm
  local NVM_PATH=$(brew --prefix nvm)/nvm.sh
  [ -s $NVM_PATH ] && . $NVM_PATH
}

load_nvm
# nvm install 4 --reinstall-packages-from=4 # lts/argon (2018-04-30)
# nvm install 6 --reinstall-packages-from=6 # lts/boron (2019-04-30)
# nvm install 8 --reinstall-packages-from=8 # lts/carbon (2019-12-31)
nvm install 10 --reinstall-packages-from=10 # lts/dubnium (2021-04-30)
nvm install 12 --reinstall-packages-from=12 # lts/erbium (2022-04-30)
nvm install 13 --reinstall-packages-from=13

nvm use 13

# npm list -g --depth=0
# + bit-bin@14.0.6
# + detox-cli@10.0.7
# + gulp-cli@2.2.0
# + ios-deploy@1.9.4
# + graphql-cli@3.0.11 https://github.com/graphql-cli/graphql-cli/issues/422, 366
# + npm-check-updates@3.1.8
# + pure-prompt@1.9.0
# + react-native-debugger-open@0.3.19
# + react-devtools@3.6.1

ncu -g | grep -o "\-g install [a-z].*" | xargs npm

# NODE CLEANUP

# Uninstall old minor node versions. i.e. remove 10.1 when 10.2 installed
nvm ls --no-alias --no-colors | tr -d ' ' | tr -d '*' | tr -d '\->' > /tmp/nvmls

# Keep all but the latest in MAJOR version if any are installed
grep '^v0' /tmp/nvmls  | sed '$d' | while read v ; do nvm uninstall $v ; done
grep '^v4' /tmp/nvmls  | sed '$d' | while read v ; do nvm uninstall $v ; done
grep '^v6' /tmp/nvmls  | sed '$d' | while read v ; do nvm uninstall $v ; done
grep '^v8' /tmp/nvmls  | sed '$d' | while read v ; do nvm uninstall $v ; done
grep '^v10' /tmp/nvmls | sed '$d' | while read v ; do nvm uninstall $v ; done
grep '^v12' /tmp/nvmls | sed '$d' | while read v ; do nvm uninstall $v ; done
grep '^v13' /tmp/nvmls | sed '$d' | while read v ; do nvm uninstall $v ; done

# Remove all from these versions
grep '^iojs-' /tmp/nvmls          | while read v ; do nvm uninstall $v ; done
grep '^v5' /tmp/nvmls             | while read v ; do nvm uninstall $v ; done
grep '^v7' /tmp/nvmls             | while read v ; do nvm uninstall $v ; done
grep '^v9' /tmp/nvmls             | while read v ; do nvm uninstall $v ; done
grep '^v11' /tmp/nvmls            | while read v ; do nvm uninstall $v ; done

rm /tmp/nvmls

# brew cu -y
# brew cu -a -y
# brew cu -f -y

pod repo update

# CocoaPods 1.7.0.rc.2 is available.
# To update use: `gem install cocoapods --pre`

# CocoaPods 1.7.0 is available.
# To update use: `gem install cocoapods`
gem install cocoapods
# pod repo update | grep \`gem install cocoapods\` ? then gem install cocoapods
