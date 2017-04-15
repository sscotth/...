#!/bin/sh
#
# Runs eval on a 'Base64'ed set of command with arguments

cmd=$(echo $@ | /usr/bin/base64 -D)

echo "Executing the command: $cmd"
echo ""
eval $cmd
