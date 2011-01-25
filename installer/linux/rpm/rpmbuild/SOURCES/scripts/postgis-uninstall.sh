#!/bin/bash

function check_root () {
  if [ ! $( id -u ) -eq 0 ]; then
    echo "This script must be run as root. Exiting."
    exit 1
  fi
}

function check_pg() {
  local status=`echo "`/etc/init.d/postgresql status`" | cut -f 3 -d ' '`
  if [ $status != "started" ]; then
    echo "WARNING: Postgresql is not running. Unable to clean up postgis."
    exit 1
  fi
}

check_root
check_pg

PG_CONTRIB=/usr/share/pgsql/contrib

# turn off error trapping, one of these may fail
set +e

su - postgres -c "psql -d template_postgis -c \"update pg_database set datistemplate = false where datname = 'template_postgis'\""
su - postgres -c "dropdb medford"
su - postgres -c "dropdb template_postgis"
su - postgres -c "dropuser opengeo"
su - postgres -c "psql -f $PG_CONTRIB/uninstall_adminpack.sql -d postgres"

# turn it back on
set -e
