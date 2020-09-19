#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

sudo mkdir /etc/pihole
sudo cp /tmp/setupVars.conf /etc/pihole/
curl -L https://install.pi-hole.net | sudo bash /dev/stdin --unattended
sudo pihole -a -p Sk1n3T

#filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb
sudo dpkg -i filebeat-7.9.0-amd64.deb

sudo sh -c "echo log-queries=extra >> /etc/dnsmasq.d/99-pihole-log-facility.conf"
