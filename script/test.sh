#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.0-amd64.deb &>/dev/null
sudo dpkg -i filebeat-7.9.0-amd64.deb

curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.0-amd64.deb &>/dev/null
sudo dpkg -i metricbeat-7.9.0-amd64.deb

sudo apt update && \
sudo apt-get install -y git libsmi2ldbl smistrip libxslt1-dev python3 libevent-dev default-libmysqlclient-dev && \
sudo apt install -y python3-pip

export PATH=$PATH:/home/ubuntu/.local/bin
pip3 install conpot
conpot -f -t default
#pip3 install --upgrade pip &>/dev/null
#pip3 install testresources &>/dev/null
#pip3 install --upgrade setuptools &>/dev/null
#pip3 install cffi &>/dev/null
#pip3 install conpot &>/dev/null
#conpot -f -t default


#-----------------

sudo apt update

sudo apt-get install -y git libsmi2ldbl smistrip libxslt1-dev python3 libevent-dev default-libmysqlclient-dev
sudo apt install -y python3-pip
#export PATH=$PATH:/home/ubuntu/.local/bin
#pip3 install conpot

#awk 'NR==1,/enabled = True/{sub(/enabled = False/, "enabled = True")} 1' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg &>/dev/null
#sudo sed -i 's/filename = \/var\/log\/conpot.json/filename = \/home\/ubuntu\/conpot.json/' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg
#setid conpot -f -t default  &>/home/ubuntu/nonFunge.txt
#echo qualcosa

export PATH=$PATH:/home/ubuntu/.local/bin
pip3 install --upgrade pip
pip3 install testresources
pip3 install --upgrade setuptools
pip3 install cffi
pip3 install conpot

awk 'NR==1,/enabled = True/{sub(/enabled = True/, "enabled = False")} 1' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg
sed -i 's/filename = \/var\/log\/conpot.json/filename = \/home\/ubuntu\/conpot.json/' /home/ubuntu/.local/lib/python3.8/site-packages/conpot/testing.cfg

nohup conpot -f -t default > qualcosa.txt &

