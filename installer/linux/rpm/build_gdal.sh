#!/bin/bash

. functions

build_info

GDAL=gdal-1.8.1

if [ -z $MRSID_ROOT ];
then
echo "Must set MRSID_ROOT to root of LizardTech Raster DSDK"
exit
fi
 
# grab files
get_file http://download.osgeo.org/gdal/$GDAL.tar.gz

cp files/$GDAL.tar.gz $RPM_SOURCE_DIR

# build
build_rpm yes

# publish
publish_rpm
