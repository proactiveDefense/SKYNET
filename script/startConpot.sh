#!/usr/bin/env bash

set -efux

sudo cp /tmp/filebeat.yml /etc/filebeat/filebeat.yml
sudo systemctl start filebeat
sudo systemctl enable filebeat

sudo cp /tmp/metricbeat.yml /etc/metricbeat/metricbeat.yml
sudo service metricbeat start
sudo systemctl enable metricbeat
