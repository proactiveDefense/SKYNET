#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux 

sudo hostnamectl set-hostname 'cowrie'

sudo apt update && \
sudo apt-get install -y git python3-virtualenv libssl-dev libffi-dev build-essential libpython3-dev python3-minimal authbind virtualenv

# shellcheck disable=SC2155
export pass=$(echo mypasswd | openssl passwd -6 -stdin)
sudo useradd -m -p $pass -s /bin/bash administrator

git clone --depth 1 --branch v2.1.0 https://github.com/cowrie/cowrie
cd cowrie
virtualenv --python=python3 cowrie-env
. cowrie-env/bin/activate
pip install --upgrade pip
pip install --upgrade -r requirements.txt
pip install pymongo

#filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb
sudo dpkg -i filebeat-7.9.0-amd64.deb
#metricbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.0-amd64.deb
sudo dpkg -i metricbeat-7.9.0-amd64.deb
#auditbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.9.0-amd64.deb
sudo dpkg -i auditbeat-7.9.0-amd64.deb

sudo sed -i '1s/^/nameserver 10.0.102.25\n/' /etc/resolv.conf