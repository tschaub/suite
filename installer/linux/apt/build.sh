#!/bin/bash

. functions

function build() {
  # clear out build directory
  if [ -d $1 ]; then
     rm -rf $1
  fi

  # unpack
  tar xzvf $1.tar.gz 
  checkrc $? "unpacking $1"

  # run setup
  if [ -e $1.setup ]; then
     #pushd $1 > /dev/null
     ./$1.setup $1
     r=$? 
     #popd > /dev/null
     checkrc $r "setup $1"
  fi

  # build
  pushd $1 > /dev/null
  debuild -uc -us -b -i
  checkrc $? "building $1"
  popd > /dev/null

  # move over artifacts
  mv *.deb *.build *.changes build
}

export SUITE_BUILDS=http://suite.opengeo.org/builds
export SUITE_DATA=http://data.opengeo.org/suite
export BRANCH=trunk
export REV=latest

# create directory for all packages
#if [ -d build ]; then
#  rm -rf build
#fi
#mkdir build

# build proj and geos
#build proj-4.7.0
#build geos

# install proj and geos libs before building postgis
#pushd build
#dpkg -r proj-data libproj0 libproj-dev
#dpkg -r libgeos-3.2.2 libgeos-c1 libgeos-dev
#dpkg -P libgeos-3.2.2 libgeos-c1
#dpkg -P libproj0
#dpkg -i proj-data_*.deb libproj0_*.deb libproj-dev_*.deb
#dpkg -i libgeos-3.2.2_*.deb libgeos-c1_*.deb libgeos-dev_*.deb 
#popd

# build postgis
#build postgis
#build pgadmin3-1.10.2
#build opengeo-postgis

# build geoserver
#build opengeo-jai
#build opengeo-geoserver

# build others
#build opengeo-docs
#build opengeo-suite-data

# build the suite
build opengeo-suite

