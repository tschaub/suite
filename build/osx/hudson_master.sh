#!/bin/bash

# Script directory
d=`dirname $0`

function usage() {
  echo "Usage: $0 "
  exit 1
}

if [ $# -ne 0 ]; then
  usage
fi

# Build proj
${d}/hudson_proj.sh proj-svn
rv=$?
if [ $rv -gt 0 ]; then
  echo "hudson_proj failed with return value $rv"
  exit 1
fi

# Build geos
${d}/hudson_geos.sh geos-svn
rv=$?
if [ $rv -gt 0 ]; then
  echo "hudson_geos failed with return value $rv"
  exit 1
fi

# Build postgis
${d}/hudson_postgis.sh postgis-svn
rv=$?
if [ $rv -gt 0 ]; then
  echo "hudson_postgis failed with return value $rv"
  exit 1
fi

# Build bundle
${d}/hudson_bundle.sh suite-build
rv=$?
if [ $rv -gt 0 ]; then
  echo "hudson_bundle failed with return value $rv"
  exit 1
fi

# Done!
exit 0

