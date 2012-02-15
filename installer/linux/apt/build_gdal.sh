#!/bin/bash

. functions

build_info

GDAL=gdal-1.8.1

# Determine which architecture we're building on
if [ `uname -m` == "i686" ]; then
    CPU_ARCH="x86"
elif [ `uname -m` == "x86_64" ]; then
    CPU_ARCH="x86-64"
fi

# grab files
get_file http://download.osgeo.org/gdal/$GDAL.tar.gz

# clean out old sources
pushd gdal
ls | grep -v debian | xargs rm -rf
popd

# unpack sources
rm -rf $GDAL
tar xzvf files/$GDAL.tar.gz
mv $GDAL/* gdal
checkrc $? "unpacking geos sources"
rmdir $gdal 

# get MrSID files
get_file http://data.opengeo.org/suite/Unified_DSDK_8.0_linux.$CPU_ARCH.gcc41.tgz

# unpack MrSID files
tar xvf files/Unified_DSDK_8.0_linux.$CPU_ARCH.gcc41.tgz Raster_DSDK
mv Raster_DSDK gdal

# build
build_deb gdal

# publish
publish_deb gdal
