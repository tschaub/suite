#!/bin/bash

rm -rf /Applications/OpenGeo
rm /private/etc/paths.d/opengeo-pgsql
rm /private/etc/manpaths.d/opengeo-pgsql
rm -rf /opt/opengeo/postgis

if [ -f /private/etc/paths.d/opengeo-pgsql ]; then
  rm /private/etc/paths.d/opengeo-pgsql
fi
if [ -f /private/etc/manpaths.d/opengeo-pgsql ]; then
  rm /private/etc/manpaths.d/opengeo-pgsql
fi

