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

./configure --prefix=${buildroot}/proj --without-mutex
make clean all
checkrv $? "Proj build"

rm -rf ${buildroot}/proj
mkdir ${buildroot}/proj
make install

pushd ${buildroot}/proj
rm -f ${webroot}/proj-win.zip
zip -r9 ${webroot}/proj-win.zip *
checkrv $? "Proj zip"
popd

popd

exit 0
    
