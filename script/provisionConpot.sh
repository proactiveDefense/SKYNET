#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

sudo apt update
sudo apt-get install -y git libsmi2ldbl smistrip libxslt1-dev python3 libevent-dev default-libmysqlclient-dev
sudo apt install -y python3-virtualenv python3-pip
pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install cffi
pip3 install conpot