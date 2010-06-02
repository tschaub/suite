#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0"
  exit 1
}

# Unzip the OpenSSL source 
getfile ${openssl_url} ${buildroot}/${openssl_file}
pushd ${buildroot}
if [ -d ${openssl_dir} ]; then
  rm -rf ${openssl_dir}
fi
tar xfz ${openssl_file}
checkrv $? "OpenSSL untar"
popd

pushd ${buildroot}/${openssl_dir}
./config \
  shared \
  --prefix=${buildroot}/pgsql 
checkrv $? "OpenSSL configure"
make && make install
checkrv $? "OpenSSL build"
popd

exit 0
    
