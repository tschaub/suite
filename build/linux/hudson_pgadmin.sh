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
getfile ${pgadmin_url} ${buildroot}/${pgadmin_file}
pushd ${buildroot}
if [ -d ${pgadmin_dir} ]; then
  rm -rf ${pgadmin_dir}
fi
tar xvfz ${pgadmin_file}
checkrv $? "PgAdmin untar"
popd

pushd ${buildroot}/${pgadmin_dir}
./configure \
  --prefix=${buildroot}/pgsql \
  --with-pgsql=${buildroot}/pgsql \
  --with-wx=${buildroot}/pgsql 
checkrv $? "PgAdmin configure"
make && make install
checkrv $? "PgAdmin build"
popd

exit

pushd ${buildroot}/${pgsql_dir}/contrib
make && make install
checkrv $? "PgSQL contrib build"
popd

exit 0
    
