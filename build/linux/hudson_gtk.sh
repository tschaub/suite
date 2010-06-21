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
getfile ${gtk_url} ${buildroot}/${gtk_file}
pushd ${buildroot}
if [ -d ${gtk_dir} ]; then
  rm -rf ${gtk_dir}
fi
tar xvfj ${gtk_file}
checkrv $? "GTK untar"
popd

pushd ${buildroot}/${gtk_dir}
export PATH=${buildroot}/glib/bin:${PATH}
export LD_LIBRARY_PATH=${buildroot}/glib/lib
./configure \
  --prefix=${buildroot}/gtk 
checkrv $? "GTK configure"
make
if [ -d ${buildroot}/gtk ]; then
  rm -rf ${buildroot}/gtk
fi
make install 
checkrv $? "GTK install"
popd

exit 0
