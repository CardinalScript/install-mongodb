# Author: Victor Kolis
# Last updated: nov-11-2022
# Purpose: Install MongoDB to Ubuntu computers (Bash) automatically

#!/bin/bash

# update system and allow insecure repositories and installing dependencies
echo -e '[1] - Updating system\nAllowing insecure repositories'
sudo apt update
sudo apt-get update --allow-insecure-repositories
sudo apt install libssl1.1


# remove old versions/mongo instances
echo '[2] - Removing old mongo instances'
sudo apt-get purge mongodb-org*
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb
systemctl stop mongod.service
systemctl disable mongod.service
sudo apt remove --autoremove mongodb-org
sudo rm /etc/apt/sources.list.d/mongodb*.list
sudo apt update

# installing gpg
echo '[3] - Installnig GPG and adding mongo key'
sudo apt install gpg
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb60.gpg


# adding the conf file to the etc
echo '[4] - Adding new repository for mongo 6.0, verifying (creating) the .conf file'
touch /etc/mongod.conf

# changing permissions of the conf file
echo '[5] - Installing mongo-org and changing the permissions to the mongo.log file'
sudo apt update
sudo apt install mongodb-org
sudo chmod 777 /var/log/mongodb/mongod.log

# setting the conf file as the standard
echo '[6] - Starting mongod.service and setting the .conf file for mongo'
systemctl enable mongod.service
systemctl start mongod.service
mongod -f /etc/mongod.conf

# start the server
# sudo mongod --dbpath /var/lib/mongodb/

echo 'BYE.'
