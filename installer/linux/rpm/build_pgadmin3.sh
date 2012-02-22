#!/bin/bash

. functions

build_info

VER=1.8.4
PGADMIN=pgadmin3-$VER
PGADMIN_POSTGIS=opengeosuite-$REV-pgadmin-postgis.zip

# grab files
get_file http://data.opengeo.org/suite/$PGADMIN.tar.gz
get_file $BUILDS/$DIST_PATH/$REV/$PGADMIN_POSTGIS

cp files/$PGADMIN.tar.gz $RPM_SOURCE_DIR
unzip files/$PGADMIN_POSTGIS -d $RPM_BUILD_DIR

# build
build_rpm yes

# publish
publish_rpm

