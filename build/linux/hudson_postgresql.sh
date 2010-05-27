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
getfile ${pgsql_url} ${buildroot}/${pgsql_file}
pushd ${buildroot}
if [ -d ${pgsql_dir} ]; then
  rm -rf ${pgsql_dir}
fi
tar xvfj ${pgsql_file}
checkrv $? "PgSQL untar"
popd

pushd ${buildroot}/${pgsql_dir}
if [ -d ${buildroot}/pgsql ]; then
  rm -rf ${buildroot}/pgsql
fi
./configure \
  --prefix=${buildroot}/pgsql \
  --with-openssl \
  --with-ldap \
  --with-pam \
  --with-gssapi
checkrv $? "PgSQL configure"
make && make install
checkrv $? "PgSQL build"
popd

pushd ${buildroot}/${pgsql_dir}/contrib
make && make install
checkrv $? "PgSQL contrib build"
popd

exit 0
    
