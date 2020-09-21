#!/usr/bin/env bash

set -efux

sudo cp /tmp/filebeat.yml /etc/filebeat/filebeat.yml
sudo systemctl start filebeat
sudo systemctl enable filebeat

sudo cp /tmp/metricbeat.yml /etc/metricbeat/metricbeat.yml
sudo service metricbeat start
sudo systemctl enable metricbeat

sudo pip3 install scapy
sudo python3 /home/ubuntu/MASTER_sym.py > /dev/null &

sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8800
sudo iptables -t nat -A PREROUTING -p tcp --dport 502 -j REDIRECT --to-port 5020