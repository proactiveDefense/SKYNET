#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

sudo apt update && \
sudo apt-get install -y git libsmi2ldbl smistrip libxslt1-dev python3 libevent-dev default-libmysqlclient-dev
sudo apt install -y python3-virtualenv python3-pip
export PATH=$PATH:/home/ubuntu/.local/bin
pip3 install --upgrade pip
pip3 install testresources
pip3 install --upgrade setuptools
pip3 install cffi
pip3 install conpot

awk 'NR==1,/enabled = True/{sub(/enabled = True/, "enabled = False")} 1' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg &>/dev/null
sudo sed -i 's/filename = \/var\/log\/conpot.json/filename = \/home\/ubuntu\/conpot.json/' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg
nohup conpot -f -t default &>/dev/null &

#filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb
sudo dpkg -i filebeat-7.9.0-amd64.deb
#metricbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.0-amd64.deb
sudo dpkg -i metricbeat-7.9.0-amd64.deb

