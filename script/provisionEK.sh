#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

#curl -sS https://deb.troglobit.com/pubkey.gpg | sudo apt-key add -
#echo "deb [arch=amd64] https://deb.troglobit.com/debian stable main" | sudo tee /etc/apt/sources.list.d/troglobit.list

sudo apt update
sudo apt install -y apt-transport-https

#elastic
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.9.0-amd64.deb
sudo dpkg -i elasticsearch-7.9.0-amd64.deb
#kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.9.0-amd64.deb
sudo dpkg -i kibana-7.9.0-amd64.deb
#metricbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.0-amd64.deb
sudo dpkg -i metricbeat-7.9.0-amd64.deb
#auditbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.9.0-amd64.deb
sudo dpkg -i auditbeat-7.9.0-amd64.deb
#filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb
sudo dpkg -i filebeat-7.9.0-amd64.deb

sudo sed -i 's/#server.host: "localhost"/server.host: 0.0.0.0/' /etc/kibana/kibana.yml
sudo service elasticsearch start
sudo service kibana start
sudo systemctl enable kibana
sudo systemctl enable elasticsearch.service

#sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt-get -y install inadyn


