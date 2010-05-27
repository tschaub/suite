#!/bin/bash

# Script directory
d=`dirname $0`

# Find script directory
pushd ${d}
p=`pwd`
popd

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0 <srcdir>"
  exit 1
}

# Check for one argument
if [ $# -lt 1 ]; then
  usage
fi

# Enter source directory
srcdir=$1
if [ ! -d $srcdir ]; then
  echo "Source directory '$srcdir' is missing."
  exit 1
else
  pushd $srcdir
fi

# Set up paths necessary to build
export PATH=${buildroot}/pgsql/bin:${PATH}
export LD_LIBRARY_PATH=${buildroot}/pgsql/lib

# Configure PostGIS
./autogen.sh
checkrv $? "PostGIS autogen"
./configure \
  --with-pgconfig=${buildroot}/pgsql/bin/pg_config \
  --with-geosconfig=${buildroot}/pgsql/bin/geos-config \
  --with-projdir=${buildroot}/pgsql \
  --with-xml2config=/usr/bin/xml2-config \
  --with-gui
checkrv $? "PostGIS configure"

# Build PostGIS
make clean && make && make install
checkrv $? "PostGIS build"

# Exit cleanly
exit 0
    
