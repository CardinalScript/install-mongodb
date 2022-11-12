#!/bin/bash

# remove the lock file
sudo rm /var/lib/mongodb/mongod.lock

# repair mondodb
mongod --repair

# start mongdb server
sudo mongod --dbpath /var/lib/mongodb/ --journal

