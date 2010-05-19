#!/bin/bash

# This script downloads the binary artefacts from other build processes and 
# assembles them in the ./binaries directory where they are packaged into
# .pkg files by Iceberg using the 'freeze' command and finally into the 
# suite .mpkg file with 'freeze' also.

dashboard_version=1.0.0
pgsql_version=8.4

dashboard_url=http://suite.opengeo.org/builds/dashboard-latest-linux.zip
suite_url=http://suite.opengeo.org/builds/opengeosuite-latest-bin.zip
ext_url=http://suite.opengeo.org/builds/opengeosuite-latest-ext.zip
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
  checkrv $? "Download $url"

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
    checkrv $? "Download $url"
    echo $url_tag > "${file}.etag"
  fi

}


#
# Check for expected subdirectories
#
if [ ! -d binaries ]; then
  exit 1
fi

#
# Retrieve and build the Dashboard pkg
#
getfile $dashboard_url binaries/dashboard.zip
if [ -d "./binaries/OpenGeo Dashboard.app" ]; then
 rm -rf "./binaries/OpenGeo Dashboard.app"
fi
unzip -o binaries/dashboard.zip -d binaries
checkrv $? "Dashboard unzip"

#
# Retrieve and build the Geoserver pkg
#
getfile $suite_url binaries/suite.zip
if [ -d binaries/suite ]; then
  rm -rf binaries/suite
fi
unzip -o binaries/suite.zip -d binaries/suite
checkrv $? "GeoServer unzip"
chmod 755 binaries/suite/opengeo-suite
cp -vf binaries/scripts/suite_uninstall.sh binaries/suite/
chmod 755 binaries/suite/suite_uninstall.sh
find binaries/suite/data_dir -type d -exec chmod 775 {} ';'
find binaries/suite/data_dir -type f -exec chmod 664 {} ';'
if [ -d "./build/GeoServer.pkg" ]; then
  find ./build/GeoServer.pkg -type f -exec chmod 644 {} ';'
  find ./build/GeoServer.pkg -type d -exec chmod 755 {} ';'
  rm -rf ./build/GeoServer.pkg
  checkrv $? "GeoServer.pkg tidy"
fi

#
# Retrieve and build the PostGIS pkg
#
#getfile $pgsql_url binaries/pgsql.zip
#if [ -d binaries/pgsql ]; then
#  rm -rf binaries/pgsql
#fi
#unzip -o binaries/pgsql.zip -d binaries/
#checkrv $? "PostGIS unzip"
#
# Copy the startup scripts into pgsql
#
#pgscriptdir=binaries/pgsql/scripts
#mkdir ${pgscriptdir}
#cp -vf binaries/scripts/*.sh ${pgscriptdir}
#cp -vf binaries/scripts/postgis ${pgscriptdir}
#rm -f ${pgscriptdir}/suite_uninstall.sh
#chmod 755 ${pgscriptdir}/*
#
# Move the apps down one directory level
#
#if [ -d binaries/pgShapeLoader.app ]; then
#  rm -rf binaries/pgShapeLoader.app
#fi
#mv binaries/pgsql/pgShapeLoader.app/ binaries/
#if [ -d binaries/stackbuilder.app ]; then
#  rm -rf binaries/stackbuilder.app
#fi
#mv binaries/pgsql/stackbuilder.app/ binaries/
#if [ -d binaries/pgAdmin3.app ]; then
#  rm -rf binaries/pgAdmin3.app
#fi
#mv binaries/pgsql/pgAdmin3.app/ binaries/
#
# Set exec bits on all apps and copy in resources
#
#chmod 755 binaries/pgShapeLoader.app/Contents/MacOS/pgShapeLoader*
#chmod 755 binaries/pgAdmin3.app/Contents/MacOS/pgAdmin3
#chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/pg_dump
#chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/pg_dumpall
#chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/pg_restore
#chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/psql
#cp -vf resources/pgadmin/settings.ini \
#      binaries/pgAdmin3.app/Contents/SharedSupport
#cp -vf resources/pgadmin/branding.ini \
#      binaries/pgAdmin3.app/Contents/SharedSupport/branding
#cp -vf resources/pgadmin/pgadmin_splash.gif \
#      binaries/pgAdmin3.app/Contents/SharedSupport/branding
#cat resources/pgadmin/plugins.ini \
# >> binaries/pgAdmin3.app/Contents/SharedSupport/plugins.ini
#
# Package up the results
#
#if [ -d "./build/PostGIS Client.pkg/" ]; then
#  rm -rf "./build/PostGIS Client.pkg/"
#fi
#freeze ./postgisclient.packproj
#checkrv $? "PostGIS client packaging"
#if [ -d "./build/PostGIS Server.pkg/" ]; then
#  rm -rf "./build/PostGIS Server.pkg/"
#fi
#freeze ./postgisserver.packproj
#checkrv $? "PostGIS server packaging"

#
# Build the GeoServer Extensions Package
#
getfile $ext_url binaries/ext.zip
if [ -d binaries/ext ]; then
  rm -rf binaries/ext
fi
unzip -o binaries/ext.zip -d binaries
checkrv $? "Ext unzip"

# 
# Build the Suite package
#
if [ -d ./suitebuild ]; then
  rm -rf ./suitebuild
fi
mkdir suitebuild
freeze ./suite.packproj
checkrv $? "Suite packaging"

#
# Exit cleanly
#
exit 0