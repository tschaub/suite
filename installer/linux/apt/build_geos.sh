#!/bin/bash

. functions

GEOS=geos-3.2.2

# grab files
get_file http://download.osgeo.org/geos/$GEOS.tar.bz2

# clean out old sources
pushd geos
ls | grep -v debian | xargs rm -rf
popd

# unpack sources
rm -rf $GEOS
tar xjvf files/$GEOS.tar.bz2
mv $GEOS/* geos
checkrc $? "unpacking geos sources"
rmdir $GEOS 

# build
exit
build_deb geos
