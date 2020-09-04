#!/usr/bin/env bash

set -efux

sudo cp /tmp/metricbeat.yml /etc/metricbeat/metricbeat.yml
sudo service metricbeat start
sudo systemctl enable metricbeat


sudo cp /tmp/filebeat-heralding.yml /etc/filebeat/filebeat.yml
sudo service filebeat start
sudo systemctl enable filebeat


sudo iptables -t nat -A PREROUTING -p tcp --dport 25 -j REDIRECT --to-port 2525
sudo iptables -t nat -A PREROUTING -p tcp --dport 21 -j REDIRECT --to-port 2121
