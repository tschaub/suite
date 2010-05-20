#!/bin/bash

# This script downloads the binary artefacts from other build processes and 
# assembles them in the ./binaries directory where they are packaged into
# .pkg files by Iceberg using the 'freeze' command and finally into the 
# suite .mpkg file with 'freeze' also.

dashboard_version=1.0.0
pgsql_version=8.4

dashboard_url=http://suite.opengeo.org/builds/dashboard-latest-linux.zip
suite_url=http://suite.opengeo.org/builds/opengeosuite-latest-bin.tar.gz
ext_url=http://suite.opengeo.org/builds/opengeosuite-latest-ext.tar.gz
jre_url=http://data.opengeo.org/suite/suite-jre-6-lin.tgz
#pgsql_url=http://suite.opengeo.org/osxbuilds/postgis-osx.zip

export PATH=$PATH:/usr/local/bin

#
# Utility function to check return values on commands
#
function checkrv {
  if [ $1 -gt 0 ]; then
    echo "$2 failed with return value $1"
    exit 1
  else
    echo "$2 succeeded return value $1"
  fi
}

#
# Utility function to download only files that have changed since 
# last download.
#
function getfile {

  local url
  local file
  local dodownload

  url=$1
  file=$2
  dodownload=yes

  url_tag=`curl -s -I $url | grep ETag | tr -d \" | cut -f2 -d' '`
  checkrv $? "ETag check at $url"

  if [ -f "${file}" ] && [ -f "${file}.etag" ]; then
    file_tag=`cat "${file}.etag"`
    if [ "x$url_tag" = "x$file_tag" ]; then
      echo "$file is already up to date"
      dodownload=no
    fi
  fi

  if [ $dodownload = "yes" ]; then
    echo "downloading fresh copy of $file"
    curl $url > $file
    checkrv $? "Download from $url"
    echo $url_tag > "${file}.etag"
  fi

}


#
# Check for expected subdirectories
# Clean up and prepare
#
if [ ! -d binaries ]; then
  mkdir binaries
fi
if [ -d binaries/root ]; then
  rm -rf binaries/root
fi
mkdir binaries/root

#
# Retrieve the suite assembly 
#
getfile $suite_url binaries/suite.tgz
if [ -d binaries/suite ]; then
  rm -rf binaries/suite
fi
mkdir binaries/suite
tar xfz binaries/suite.tgz -C binaries/suite
checkrv $? "GeoServer untar"

# 
# Retrieve the Linux JRE
#
getfile $jre_url binaries/jre.tgz
tar xfz binaries/jre.tgz -C binaries/suite/*
checkrv $? "JRE untar"

#
# Repackage the Suite component 
#
pushd binaries/suite
NAME=`ls`
tar cfz ../root/${NAME}.tar.gz *
checkrv $? "Suite retar"
rm -rf *
popd

#
# Retrieve and build the Dashboard 
#
getfile $dashboard_url binaries/dashboard.zip
if [ -d "./binaries/root/OpenGeo Dashboard" ]; then
 rm -rf "./binaries/root/OpenGeo Dashboard"
fi
unzip -q -o binaries/dashboard.zip -d binaries/suite
checkrv $? "Dashboard unzip"
touch "./binaries/suite/OpenGeo Dashboard/.installed"
pushd binaries/suite
NAME=`ls`
tar cfz "../root/${NAME}.tar.gz" *
checkrv $? "Dashboard retar"
rm -rf *
popd

#
# Retreive the GeoServer extensions package
#
EXTFILE=`basename $ext_url`
getfile $ext_url binaries/${EXTFILE}
cp binaries/${EXTFILE} binaries/root

# 
# Copy in some useful files
#
cp ../common/license.txt binaries/root

#
# Build installer script
#
makeself-2.1.5/makeself.sh ./binaries/root OpenGeoSuite.bin "OpenGeo Suite" ./install.sh

exit

