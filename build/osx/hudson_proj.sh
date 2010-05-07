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

# Unsip the 
if [ ! -f ${buildroot}/${proj_nad} ]; then
  curl http://download.osgeo.org/proj/${proj_nad} > ${buildroot}/${proj_nad}
fi
pushd nad
unzip -o ${buildroot}/${proj_nad}
popd

./autogen.sh
export CXX=g++-4.0 
export CC=gcc-4.0 
export CXXFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4"
export CFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4"
./configure --prefix=${buildroot}/proj --disable-dependency-tracking
make clean all
if [ $rv -gt 0 ]; then
  echo "Proj build failed with return value $rv"
  exit 1
fi

rm -rf ${buildroot}/proj
mkdir ${buildroot}/proj
make install

pushd ${buildroot}/proj
rm -f ${webroot}/proj-osx.zip
zip -r9 ${webroot}/proj-osx.zip *
popd

popd

exit 0
    
