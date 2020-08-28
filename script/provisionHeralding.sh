#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

sudo apt update
export PATH=$PATH:/home/ubuntu/.local/bin

sudo add-apt-repository -y ppa:deadsnakes/ppa && sudo apt-get -y update
sudo apt-get install -y python3.6 python3.6-dev python3-pip python3-virtualenv
sudo apt-get install -y build-essential libssl-dev libffi-dev libpq-dev
virtualenv --python=python3.6 heralding
source heralding/bin/activate
pip3 install heralding
cp /tmp/heralding.yml /home/ubuntu/heralding/lib/python3.6/site-packages/heralding/heralding.yml
nohup heralding &

#filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb
sudo dpkg -i filebeat-7.9.0-amd64.deb
#metricbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.0-amd64.deb
sudo dpkg -i metricbeat-7.9.0-amd64.deb

