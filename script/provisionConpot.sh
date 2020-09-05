#!/usr/bin/env bash

# -e  Exit immediately if a command exits with a non-zero status.
# -f  Disable file name generation (globbing).
# -u  Treat unset variables as an error when substituting.
#set -efux

#filebeatdefault
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb
sudo dpkg -i filebeat-7.9.0-amd64.deb
#metricbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.0-amd64.deb
sudo dpkg -i metricbeat-7.9.0-amd64.deb

sudo apt update

sudo apt-get install -y git libsmi2ldbl smistrip libxslt1-dev python3.6 libevent-dev default-libmysqlclient-dev
sudo apt install python3-virtualenv

#export PATH=$PATH:/home/ubuntu/.local/bin
#virtualenv --python=python3 conpot
#source conpot/bin/activate
#sudo pip3 install --upgrade pip
#sudo pip3 install testresources
#sudo pip3 install --upgrade setuptools
#sudo pip3 install cffi
#sudo pip3 install conpot
#echo $USER >> qualcosa
#cp qualcosa /home/ubuntu/
#cp -r conpot /home/ubuntu/

#awk 'NR==1,/enabled = True/{sub(/enabled = True/, "enabled = False")} 1' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg &>/dev/null
#sudo sed -i 's/filename = \/var\/log\/conpot.json/filename = \/home\/ubuntu\/conpot.json/' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg
#conpot -f -t default &>/dev/null &

#curl -fsSL https://get.docker.com -o get-docker.sh
#chmod +x get-docker.sh
#sudo sh get-docker.sh
#sudo docker pull honeynet/conpot
#sudo docker run honeynet/conpot:latest
