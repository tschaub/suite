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
  exit 1
else 
  pushd $srcdir
fi

./autogen.sh
export CXX=g++-4.0 
export CC=gcc-4.0 
export CXXFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4" 
export CFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4" 
./configure --prefix=${buildroot}/geos --disable-dependency-tracking
make clean && make all
if [ $rv -gt 0 ]; then
  echo "GEOS build failed with return value $rv"
  exit 1
fi

rm -rf ${buildroot}/geos
mkdir ${buildroot}/geos
make install
pushd ${buildroot}/geos
rm -f ${webroot}/geos-osx.zip
zip -r9 ${webroot}/geos-osx.zip *
popd

popd

exit 0
    
