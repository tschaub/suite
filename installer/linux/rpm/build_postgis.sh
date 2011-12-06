#!/bin/bash

. functions

build_info

POSTGIS=postgis-1.5.3

# grab files
get_file http://postgis.refractions.net/download/$POSTGIS.tar.gz
cp files/$POSTGIS.tar.gz $RPM_SOURCE_DIR

# build
build_rpm yes

# publish
publish_rpm

