#!/bin/bash

d=`dirname $0`
source ${d}/pg_config.sh

bin=$(pg_check_bin)
if [ "$bin" != "good" ]; then
  echo "Cannot find PgSQL component: $bin"
  exit 1
fi

# We want to run all these as postgres superuser
export PGUSER=postgres

"$pg_bin_dir/createuser" --createdb --superuser $USER >> "$pg_log"
rv=$?
if [ $rv -gt 0 ]; then
  echo "Create user failed with return value $rv"
  exit 1
fi

"$pg_bin_dir/createdb" --owner=$USER --template=template_postgis $USER >> "$pg_log"
rv=$?
if [ $rv -gt 0 ]; then
  echo "Create user failed with return value $rv"
  exit 1
fi

exit 0

