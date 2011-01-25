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
    echo "NOTICE: Postgresql is not running. Run this script once the Postgresql server has been started"
    exit 1
  fi
}

check_root
check_pg

PG_CONTRIB=/usr/share/pgsql/contrib
echo "Initializing template_postgis database"
su - postgres -c "createdb template_postgis"
su - postgres -c "createlang plpgsql template_postgis"
su - postgres -c "psql -d template_postgis -f $PG_CONTRIB/postgis-1.5/postgis.sql" > /dev/null
su - postgres -c "psql -d template_postgis -f $PG_CONRIB/postgis-1.5/spatial_ref_sys.sql" > /dev/null
su - postgres -c "psql -d template_postgis -c \"update pg_database set d
atistemplate = true where datname = 'template_postgis'\""

# Adds PgAdmin utilities to the 'postgres' database
echo "Installing postgresql admin pack"
su - postgres -c "psql -f $PG_CONRIB/adminpack.sql -d postgres" > /dev/null

# Create an 'opengeo' user
echo "Creating opengeo database"
su - postgres -c "createuser --createdb --superuser opengeo"

# Set the user password?
su - postgres -c "psql -d postgres -c \"alter user opengeo password 'opengeo'\""

# create demo database
su - postgres -c "createdb --owner=opengeo --template=template_postgis medford"

echo "Updating pg_hba.conf"
PG_HBA=/var/lib/pgsql/data/pg_hba.conf

if [ ! -e $PG_HBA ]; then
  printf "Unable to locate PGDATA directory. Please add the following line to pg_hba.conf to finalize configuration:
    
     local		all 	opengeo 	md5
"
  exit 0
fi

# back up old file
cp $PG_HBA $PG_HBA.orig
if [ ! `cat $PG_HBA | grep opengeo | wc -l` ]; then
   echo "local     all    opengeo               md5" >> $PG_HBA
fi
/etc/init.d/postgresql restart
