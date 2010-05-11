#!/bin/bash

export PATH=/bin:/usr/bin:${PATH}

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
./configure --prefix=${buildroot}/geos 
make clean && make 
checkrv $? "GEOS build"

rm -rf ${buildroot}/geos
mkdir ${buildroot}/geos
make install
pushd ${buildroot}/geos
rm -f ${webroot}/geos-win.zip
zip -r9 ${webroot}/geos-win.zip *
checkrv $? "GEOS zip"
popd

popd

exit 0
    
