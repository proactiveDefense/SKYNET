#!/bin/bash
set -efux

wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt-get install -y mongodb-org
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
sudo systemctl daemon-reload
sudo systemctl start mongod
sudo systemctl enable mongod
sleep 5
mongo --eval "db.getSiblingDB('cowrie').createUser({ user : 'cowrie', pwd :  'cowrie', roles : [{ role: 'dbOwner', db: 'cowrie'}]});"