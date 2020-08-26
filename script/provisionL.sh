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
sudo dpkg -i logstash-7.9.0.deb && \
sudo cp /tmp/log-cow.conf /etc/logstash/conf.d/
sudo service logstash start

sudo sed -i '$a output.elasticsearch.index: "%{[@metadata][beat]}-%{[@metadata][version]}\"' /etc/metricbeat/metricbeat.yml
sudo sed -i '$a setup.template.name: "%{[@metadata][beat]}\"' /etc/metricbeat/metricbeat.yml
sudo sed -i '$a setup.template.pattern: "%{[@metadata][beat]}-*\"' /etc/metricbeat/metricbeat.yml
sudo metricbeat setup


sudo mv /tmp/inadyn.conf /etc/inadyn.conf
sudo service inadyn restart

