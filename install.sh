#!/bin/bash

readonly ROCKETCHATCTL_DOWNLOAD_URL="https://raw.githubusercontent.com/MartyVador/install.sh/master/rocketchatctl"
readonly ROCKETCHATCTL_DIRECTORY="/usr/local/bin"

if [ ${EUID} -ne 0 ]; then
    echo "This script must be run as root. Cancelling" >&2
    exit 1
fi
if ! [[ -t 0 ]]; then
    echo "This script is interactive, please run: bash -c \"\$(curl https://install.rocket.chat)\"" >&2
    exit 1
fi
if [ ! -f "$ROCKETCHATCTL_DIRECTORY/rocketchatctl" ]; then
    curl -L $ROCKETCHATCTL_DOWNLOAD_URL -o /tmp/rocketchatctl
    if  [ $? != 0 ]; then
        echo "Error downloading rocketchatctl."
        exit 1
    else
        mv /tmp/rocketchatctl $ROCKETCHATCTL_DIRECTORY/
        chmod 755 $ROCKETCHATCTL_DIRECTORY/rocketchatctl
    fi
    $ROCKETCHATCTL_DIRECTORY/rocketchatctl install $@
else
    echo "You already have rocketchatctl installed, use rocketchatctl to manage your RocketChat installation."
    echo "Run rocketchatctl help for more info."
    exit 1
fi
