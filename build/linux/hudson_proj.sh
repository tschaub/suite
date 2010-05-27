#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0 <srcdir>"
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

srcdir=$1

if [ ! -d $srcdir ]; then
  echo "Source directory '$srcdir' is missing."
  exit 1
else
  pushd $srcdir
fi

# Unzip the 
getfile http://download.osgeo.org/proj/${proj_nad} ${buildroot}/${proj_nad}
pushd nad
unzip -o ${buildroot}/${proj_nad}
popd

./autogen.sh
./configure --prefix=${buildroot}/pgsql
make clean && make && make install
checkrv $? "Proj build"

# exit srcdir
popd

exit 0

