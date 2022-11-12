# Author: Victor Kolis
# Last updated: nov-11-2022
# Purpose: Install MongoDB to Debian based computers (Bash) automatically

#!/bin/bash

# update system and allow insecure repositories
sudo apt update
apt-get update --allow-insecure-repositories

# remove old versions/mongo instances
sudo apt-get purge mongodb-org*
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb

# adding server key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

# adding the repository link and architecture to the mongo list and updating system
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update

# installing the possible broken/not yet installed dependencies
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
rm -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb

# adding the conf file to the etc
touch /etc/mongod.conf

# changing permissions of the conf file
sudo chmod 777 /var/log/mongodb/mongod.log

# setting the conf file as the standard
mongod -f /etc/mongod.conf

# starting connection/serving/service
sudo service mongod start

# start the server
# sudo mongod --dbpath /var/lib/mongodb/

echo 'BYE.'
