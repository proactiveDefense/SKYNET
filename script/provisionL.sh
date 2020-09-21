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
#sudo mkdir patterns
#sudo cp /tmp/20-dns-syslog.conf /etc/logstash/conf.d/
#sudo cp /tmp/dns /etc/logstash/patterns/dns

sudo sed -i '$a output.elasticsearch.index: "%{[@metadata][beat]}-%{[@metadata][version]}\"' /etc/metricbeat/metricbeat.yml
sudo sed -i '$a setup.template.name: "%{[@metadata][beat]}\"' /etc/metricbeat/metricbeat.yml
sudo sed -i '$a setup.template.pattern: "%{[@metadata][beat]}-*\"' /etc/metricbeat/metricbeat.yml
sudo metricbeat setup

sudo sed -i '$a output.elasticsearch.index: "%{[@metadata][beat]}-%{[@metadata][version]}\"' /etc/auditbeat/auditbeat.yml
sudo sed -i '$a setup.template.name: "%{[@metadata][beat]}\"' /etc/auditbeat/auditbeat.yml
sudo sed -i '$a setup.template.pattern: "%{[@metadata][beat]}-*\"' /etc/auditbeat/auditbeat.yml
sudo auditbeat setup

sudo service logstash start

#curl -X POST "localhost:5601/api/saved_objects/_import" -H "kbn-xsrf: true" --form file=@/tmp/export.ndjson
curl -X POST "localhost:5601/api/saved_objects/_import" -H "kbn-xsrf: true" --form file=@/tmp/dash_pihole.ndjson

#sudo mv /tmp/inadyn.conf /etc/inadyn.conf
#sudo service inadyn restart

