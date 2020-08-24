#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

sudo apt update
export PATH=$PATH:/home/ubuntu/.local/bin
sudo apt-get install -y python3-pip python3.6 build-essential libssl-dev libffi-dev libpq-dev
sudo pip3 install heralding


