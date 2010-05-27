#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0 <destdir>"
  exit 1
}

# Check for one argument
if [ $# -lt 1 ]; then
  usage
fi

workdir=`pwd`
destdir=$1

# Check that we have a mostly-built pgsql in the buildroot...
if [ ! -d ${buildroot}/pgsql ]; then
  echo "Missing pgsql buildroot! ${buildroot}/pgsql"
  exit 1
fi

# Tar up the results 
binfile=pgsql-postgis-linux32.tar.gz
pushd ${buildroot}
if [ -f ${workdir}/${binfile} ]; then
  rm -f ${workdir}/${binfile}
fi
tar cvfz ${workdir}/${binfile} pgsql
checkrv $? "Bundle zip"
echo "Wrote ${binfile} to $workdir"
popd

# Move the results to the web directory
mv -fv ${workdir}/${binfile} ${destdir}
checkrv $? "Move tarball to web"

# Exit cleanly
exit 0
