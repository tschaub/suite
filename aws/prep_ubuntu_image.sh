#!/bin/bash

. functions

wget -qO- http://apt.opengeo.org/gpg.key | sudo apt-key add - 
check_rc $? "apt-key add"

sudo bash -c "echo 'deb http://apt.opengeo.org/ubuntu lucid main' >> /etc/apt/sources.list"
check_rc $? "adding opengeo ubuntu repo"

sudo apt-get update
check_rc $? "apt-get update"

echo "opengeo-geoserver opengeo_geoserver/proxyurl string " | sudo debconf-set-selections 
echo "opengeo-geoserver opengeo_geoserver/username string " | sudo debconf-set-selections 
echo "opengeo-geoserver opengeo_geoserver/password string " | sudo debconf-set-selections 
check_rc $? "debconf-set-selections"

sudo apt-get install opengeo-suite
check_rc $? "apt-get -y install opengeo-suite" 
