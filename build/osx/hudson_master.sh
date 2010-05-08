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

# Build postgis
echo "Running hudson_postgis.sh..."
${d}/hudson_postgis.sh postgis-svn
rv=$?
if [ $rv -gt 0 ]; then
  echo "hudson_postgis failed with return value $rv"
  exit $rv
fi

# Build bundle
echo "Running hudson_bundle.sh..."
${d}/hudson_bundle.sh suite-build
rv=$?
if [ $rv -gt 0 ]; then
  echo "hudson_bundle failed with return value $rv"
  exit $rv
fi

# Done!
exit 0

