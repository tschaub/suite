#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0"
  exit 1
}

# Unzip the PostgreSQL source 
getfile ${glib_url} ${buildroot}/${glib_file}
pushd ${buildroot}
if [ -d ${glib_dir} ]; then
  rm -rf ${glib_dir}
fi
tar xvfj ${glib_file}
checkrv $? "GLib untar"
popd

pushd ${buildroot}/${glib_dir}
./configure \
  --prefix=${buildroot}/glib \
  --enable-threads
checkrv $? "GLib configure"
make
if [ -d ${buildroot}/glib ]; then
  rm -rf ${buildroot}/glib
fi
make install 
checkrv $? "GLib install"
popd

exit 0
