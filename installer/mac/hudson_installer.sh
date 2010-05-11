#!/bin/bash

# This script downloads the binary artefacts from other build processes and 
# assembles them in the ./binaries directory where they are packaged into
# .pkg files by Iceberg using the 'freeze' command and finally into the 
# suite .mpkg file with 'freeze' also.

dashboard_version=1.0.0
pgsql_version=8.4

dashboard_url=http://suite.opengeo.org/builds/dashboard-latest-osx.zip
suite_url=http://suite.opengeo.org/builds/opengeosuite-latest-mac.zip
ext_url=http://suite.opengeo.org/builds/opengeosuite-latest-ext.zip
pgsql_url=http://10.52.11.40/suite/postgis-osx.zip

export PATH=$PATH:/usr/local/bin

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
# Utility function to download only files that have changed since 
# last download.
#
function getfile {

  local url
  local file

  url=$1
  file=$2

  url_tag=`curl -s -I $url | grep ETag | tr -d \" | cut -f2 -d' '`
  checkrv $? "Download $url"

  if [ -f "${file}" ]; then
    if [ -f "${file}.etag" ]; then
      file_tag=`cat "${file}.etag"`
      if [ $url_tag = $file_tag ]; then
        echo "$file is already up to date"
      else
        echo "downloading fresh copy of $file"
        curl $url > $file
        checkrv $? "Download $url"
        echo $url_tag > "${file}.etag"
      fi
    fi
  else
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
if [ ! -d build ]; then
  mkdir build
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
if [ -d "./build/Dashboard.pkg" ]; then
   rm -rf "./build/Dashboard.pkg"
fi
freeze ./dashboard.packproj
checkrv $? "Dashboard packaging"

#
# Retrieve and build the Geoserver pkg
#
getfile $suite_url binaries/opengeosuite.zip
if [ -d binaries/suite ]; then
  rm -rf binaries/suite
fi
unzip -o binaries/opengeosuite.zip -d binaries/suite
checkrv $? "GeoServer unzip"
chmod 755 binaries/suite/opengeo-suite
cp binaries/scripts/suite_uninstall.sh binaries/suite/
chmod 755 binaries/suite/suite_uninstall.sh
find binaries/suite/data_dir -type d -exec chmod 775 {} ';'
find binaries/suite/data_dir -type f -exec chmod 664 {} ';'
if [ -d "./build/GeoServer.pkg" ]; then
  rm -rf ./build/GeoServer.pkg
fi
freeze ./geoserver.packproj
checkrv $? "GeoServer packaging"

#
# Retrieve and build the PostGIS pkg
#
getfile $pgsql_url binaries/pgsql.zip
if [ -d binaries/pgsql ]; then
  rm -rf binaries/pgsql
fi
unzip -o binaries/pgsql.zip -d binaries/
checkrv $? "PostGIS unzip"
#
# Copy the startup scripts into pgsql
#
pgscriptdir=binaries/pgsql/scripts
mkdir ${pgscriptdir}
cp -f binaries/scripts/bin/*.sh ${pgscriptdir}
cp -f binaries/scripts/bin/postgis ${pgscriptdir}
rm -f ${pgscriptdir}/suite_uninstall.sh
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
getfile $ext_url binaries/ext.zip
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
# Prepare for DMG
#
#mkdir suitebuild/background
#cp resources/dmg_background.bmp suitebuild/background/background.bmp
cp -f resources/OpenGeo.icns suitebuild/.VolumeIcon.icns
#
# Build the DMG volume
#
VOL="OpenGeoSuite"
DMG="tmp-${VOL}.dmg"
DMGFINAL="${VOL}"
if [ -d "${DMGFINAL}" ]; then
  rm -rf "${DMGFINAL}"
fi
mv suitebuild "${DMGFINAL}"
hdiutil create "$DMG" -srcfolder "${DMGFINAL}"
checkrv $? "Suite volume create"
# convert to compressed image, delete temp image
if [ -f "${DMGFINAL}.dmg" ]; then 
  rm -f "${DMGFINAL}.dmg"
fi
hdiutil convert "$DMG" -format UDZO -o "${DMGFINAL}.dmg"
checkrv $? "Suite compressing"
if [ -f "${DMG}" ]; then 
  rm -f "${DMG}"
fi

exit 0
