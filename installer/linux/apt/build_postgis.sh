#!/bin/bash

. functions

POSTGIS=postgis-1.5.2

# grab files
get_file http://postgis.refractions.net/download/$POSTGIS.tar.gz

# clean out old sources
pushd postgis
ls | grep -v debian | xargs rm -rf
popd

# unpack sources
rm -rf $POSTGIS
tar xzvf files/$POSTGIS.tar.gz
mv $POSTGIS/* postgis
checkrc $? "unpacking postgis sources"
rmdir $POSTGIS 

# build
exit
build_deb postgis
