#!/bin/bash

# This script downloads the binary artefacts from other build processes and 
# assembles them in the ./binaries directory where they are packaged into
# .pkg files by Iceberg using the 'freeze' command and finally into the 
# suite .mpkg file with 'freeze' also.

dashboard_version=1.0.0

dashboard_url=http://suite.opengeo.org/builds/dashboard-latest-osx.zip
dashboard_url=http://localhost/~pramsey/dashboard.zip

suite_url=http://suite.opengeo.org/builds/opengeosuite-latest-mac.zip
ext_url=http://suite.opengeo.org/builds/opengeosuite-latest-ext.zip
pgsql_url=http://10.52.11.40/suite/postgis-osx.zip

#
# Utility function to check return values on commands
#
function checkrv {
  if [ $1 -gt 0 ]; then
    echo "$2 failed with return value $1"
    exit 1
  fi
}

#
# Check for expected subdirectories
#
if [ ! -d binaries ]; then
  exit 1
fi
if [ ! -d build ]; then
  mkdir build
fi

#
# Retrieve and build the Dashboard pkg
#
curl $dashboard_url > binaries/dashboard.zip
checkrv $? "Dashboard download"
if [ -d "./binaries/OpenGeo Dashboard.app" ]; then
 rm -rf "./binaries/OpenGeo Dashboard.app"
fi
unzip -o binaries/dashboard.zip -d binaries
checkrv $? "Dashboard unzip"
if [ -d "./build/Dashboard.pkg" ]; then
   rm -rf "./build/Dashboard.pkg"
fi
freeze ./dashboard.packproj
checkrv $? "Dashboard packaging"

#
# Retrieve and build the Geoserver pkg
#
curl $suite_url > binaries/suite.zip
checkrv $? "GeoServer download"
if [ -d binaries/geoserver ]; then
  rm -rf binaries/geoserver
fi
unzip -o binaries/suite.zip -d binaries/geoserver
checkrv $? "GeoServer unzip"
chmod 755 binares/geoserver/opengeo-suite
find binaries/geoserver/data_dir -type d -exec chmod 775 {} ';'
find binaries/geoserver/data_dir -type f -exec chmod 664 {} ';'
if [ -d "./build/GeoServer.pkg" ]; then
  rm -rf ./build/GeoServer.pkg
fi
freeze ./geoserver.packproj
checkrv $? "GeoServer packaging"

#
# Retrieve and build the PostGIS pkg
#
curl $pgsql_url > binaries/pgsql.zip
checkrv $? "PostGIS download"
if [ -d binaries/pgsql ]; then
  rm -rf binaries/pgsql
fi
unzip -o binaries/pgsql.zip -d binaries/
checkrv $? "PostGIS unzip"
#
# Move the apps down one directory level
#
if [ -d binaries/pgShapeLoader.app ]; then
  rm -rf binaries/pgShapeLoader.app
fi
mv binaries/pgsql/pgShapeLoader.app/ binaries/
if [ -d binaries/stackbuilder.app ]; then
  rm -rf binaries/stackbuilder.app
fi
mv binaries/pgsql/stackbuilder.app/ binaries/
if [ -d binaries/pgAdmin3.app ]; then
  rm -rf binaries/pgAdmin3.app
fi
mv binaries/pgsql/pgAdmin3.app/ binaries/
#
# Set exec bits on all apps and copy in resources
#
chmod 755 binaries/pgShapeLoader.app/Contents/MacOS/pgShapeLoader*
chmod 755 binaries/pgAdmin3.app/Contents/MacOS/pgAdmin3
chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/pg_dump
chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/pg_dumpall
chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/pg_restore
chmod 755 binaries/pgAdmin3.app/Contents/SharedSupport/psql
cp -f resources/pgadmin/settings.ini \
      binaries/pgAdmin3.app/Contents/SharedSupport
cp -f resources/pgadmin/branding.ini \
      binaries/pgAdmin3.app/Contents/SharedSupport/branding
cp -f resources/pgadmin/pgadmin_splash.gif \
      binaries/pgAdmin3.app/Contents/SharedSupport/branding
cat resources/pgadmin/plugins.ini \
 >> binaries/pgAdmin3.app/Contents/SharedSupport/plugins.ini
#
# Package up the results
#
if [ -d "./build/PostGIS Client.pkg/" ]; then
  rm -rf "./build/PostGIS Client.pkg/"
fi
freeze ./postgisclient.packproj
checkrv $? "PostGIS client packaging"
if [ -d "./build/PostGIS Server.pkg/" ]; then
  rm -rf "./build/PostGIS Server.pkg/"
fi
freeze ./postgisserver.packproj
checkrv $? "PostGIS server packaging"

#
# Build the Suite Scripts Package
#
find ./binaries -name "*.sh" -exec chmod 755 {} ';'
freeze ./suitescripts.packproj
checkrv $? "Suite scripts packaging"

#
# Build the GeoServer Extensions Package
#
curl $ext_url > binaries/ext.zip
checkrv $? "Ext download"
if [ -d binaries/ext ]; then
  rm -rf binaries/ext
fi
unzip -o binaries/ext.zip -d binaries
checkrv $? "Ext unzip"
if [ -d "./build/GeoServer Extensions.pkg" ]; then
  rm -rf "./build/GeoServer Extensions.pkg"
fi
freeze ./geoserverext.packproj
checkrv $? "Ext packaging"

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
# Zip the mpkg
#
pushd suitebuild
zip -r9 ../OpenGeoSuite.zip "OpenGeo Suite.mpkg" 
checkrv $? "Suite zipping"
popd

exit 0
