#!/usr/bin/env bash
#
# utility functions
#

command_exists () {
	type "$1" &> /dev/null
}

boxecho () {
  msg="# $* #"
  edge=$(echo "$msg" | sed 's/./#/g')

  if command_exists lolcat; then
    echo -e "\n$edge\n$msg\n$edge\n" | lolcat
  else
    echo -e "\n$edge\n$msg\n$edge\n"
  fi
}

# Retries a command on failure
# Based on http://fahdshariff.blogspot.com/2014/02/retrying-commands-in-shell-scripts.html
# TODO: Accept optional MAX_ATTEMPTS and DELAY arguments
retry_command () {
    local -r -i MAX_ATTEMPTS=3
    local -r -i DELAY=10
    local -i index=1
    echo "==> RETRY_COMMAND <=="

    until $@; do
      local exit_status=$?
      echo "Exit code: $exit_status"

        if [[ $exit_status -eq 72 ]]; then
            echo Unrecoverable Error 72
            return 72
        elif (( index == MAX_ATTEMPTS )); then
            echo "Attempt $index failed and there are no more attempts left!"
            # echo "(Attempt $index failed!)" >&3
            return 1
        else
            echo "Attempt $index failed! Trying again in $(( DELAY * index )) seconds..."
            # echo "(Attempt $index failed. Waiting $(( DELAY * index )) seconds...)" >&3
            sleep $(( DELAY * index++ ))
        fi
    done
}

# Caches the sudo password as a variable for scripts.
# Some scripts cannot be as sudo like homebrew, but requires a password during certain tasks.
# Use psudo for those scripts.
cached_psudo () {
  if [ -z ${SUDOPASS+x} ]; then
    read -s -p "SUDO Password:" SUDOPASS
    export SUDOPASS=$SUDOPASS
    echo ''
  fi

  base64_cmd=$(echo $@ | base64 | tr -d '\n')

  /usr/bin/expect <<EOD
    set timeout -1
    spawn ./lib/base64_eval.sh $base64_cmd
    expect {
      "*?assword:*" { send "$SUDOPASS\n"; exp_continue }
      eof
    }

    catch wait result
    exit [lindex \$result 3]
EOD
}

cached_sudo () {
  if [ -z ${SUDOPASS+x} ]; then
    read -s -p "SUDO Password:" SUDOPASS
    export SUDOPASS=$SUDOPASS
    echo ''
  fi

  base64_cmd=$(echo sudo $@ | base64 | tr -d '\n')
  echo "base64_cmd: $base64_cmd"

  /usr/bin/expect <<EOD
    set timeout -1
    spawn ./lib/base64_eval.sh $base64_cmd
    expect {
      "*?assword:*" { send "$SUDOPASS\n"; exp_continue }
      eof
    }

    catch wait result
    exit [lindex \$result 3]
EOD
}

# Loads nvm into the current shell
load_nvm () {
  echo "LOADING nvm.sh"

  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

  echo "Loaded nvm v$(nvm --version)"
}
