#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

sudo apt update
sudo apt-get install apt-transport-https
sudo apt install default-jre
#elastic
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.9.0-amd64.deb
sudo dpkg -i elasticsearch-7.9.0-amd64.deb
#kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.9.0-amd64.deb
sudo dpkg -i kibana-7.9.0-amd64.deb
#logstash
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.9.0.deb
sudo dpkg -i logstash-7.9.0.deb






