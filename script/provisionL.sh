#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
set -efux

sudo apt update && sudo apt install -y openjdk-14-jre
sudo mkdir -p /opt/logstash/vendor/geoip/
sudo cp /tmp/GeoLite2-City.mmdb /opt/logstash/vendor/geoip/

#logstash
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.9.0.deb
sudo dpkg -i logstash-7.9.0.deb

