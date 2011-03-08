#!/bin/bash

. functions

# add the repos for sun jdk and opengeo
sudo bash -c "echo 'deb http://archive.canonical.com/ lucid partner' >> /etc/apt/sources.list"

wget -qO- http://apt.opengeo.org/gpg.key | sudo apt-key add - 
check_rc $? "apt-key add"

sudo bash -c "echo 'deb http://apt.opengeo.org/ubuntu lucid main' >> /etc/apt/sources.list"
check_rc $? "adding opengeo ubuntu repo"

sudo apt-get update
check_rc $? "apt-get update"

# populate the debconf database so we can run headless
echo "sun-java6-jdk shared/accepted-sun-dlj-v1-1 select true" | sudo debconf-set-selections 
echo "opengeo-geoserver opengeo_geoserver/proxyurl string " | sudo debconf-set-selections 
echo "opengeo-geoserver opengeo_geoserver/username string " | sudo debconf-set-selections 
echo "opengeo-geoserver opengeo_geoserver/password string " | sudo debconf-set-selections 
check_rc $? "debconf-set-selections"

# install the sun jdk
sudo apt-get -y install sun-java6-jdk
check_rc $? "apt-get -y install sun-java6-jdk" 
update-java-alternatives -s java-6-sun

# install the suite
sudo apt-get -y install opengeo-suite
check_rc $? "apt-get -y install opengeo-suite" 

