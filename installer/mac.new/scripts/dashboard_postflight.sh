#!/bin/bash

dashboard="/Applications/OpenGeo/OpenGeo Dashboard.app"
configini="$dashboard/Contents/Resources/config.ini"

if [ -d "$dashboard" ] 
then
  sed -i .bak 's/@SUITE_EXE@/\/opt\/opengeo\/geoserver\/opengeo-suite/g' "$configini"
  sed -i .bak 's/@SUITE_DIR@/\/opt\/opengeo\/geoserver/g' "$configini"
  sed -i .bak 's/@GEOSERVER_DATA_DIR@/\/opt\/opengeo\/geoserver\/data_dir/g' "$configini"
fi

open /Applications/OpenGeo/Dashboard.app
exit 0
