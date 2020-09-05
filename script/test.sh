#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb &>/dev/null
sudo dpkg -i filebeat-7.9.0-amd64.deb &>/dev/null

curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.0-amd64.deb &>/dev/null
sudo dpkg -i metricbeat-7.9.0-amd64.deb &>/dev/null

apt update &>/dev/null && \
apt-get install -y git libsmi2ldbl smistrip libxslt1-dev python3 libevent-dev default-libmysqlclient-dev &>/dev/null && \
apt install -y python3-pip &>/dev/null
export PATH=$PATH:/home/ubuntu/.local/bin
pip3 install conpot &>/dev/null
conpot -f -t default
#pip3 install --upgrade pip &>/dev/null
#pip3 install testresources &>/dev/null
#pip3 install --upgrade setuptools &>/dev/null
#pip3 install cffi &>/dev/null
#pip3 install conpot &>/dev/null
#conpot -f -t default


