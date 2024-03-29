#!/usr/bin/env bash

set -efux

cd cowrie
virtualenv --python=python3 cowrie-env
. cowrie-env/bin/activate

./bin/cowrie start
sudo sed -i 's/#Port 22/Port 40000/' /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222

sudo cp /tmp/filebeat.yml /etc/filebeat/filebeat.yml
sudo systemctl start filebeat
sudo systemctl enable filebeat


sudo cp /tmp/metricbeat.yml /etc/metricbeat/metricbeat.yml
sudo service metricbeat start
sudo systemctl enable metricbeat

sudo cp /tmp/auditbeat.yml /etc/auditbeat/auditbeat.yml
sudo service auditbeat start
sudo systemctl enable auditbeat


#sudo apt-get install -y auditd audispd-plugins
#sudo auditctl -w / -p war
