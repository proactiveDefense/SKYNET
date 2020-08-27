#!/usr/bin/env bash

set -efux

sudo cp /tmp/metricbeat.yml /etc/metricbeat/metricbeat.yml
sudo service metricbeat start

source heralding/bin/activate
heralding &>/dev/null &