#!/bin/bash

. functions

build_info

# grab files
DATA_DIR=opengeosuite-$REV-data-dir.zip
get_file $BUILDS/$DIST_PATH/$REV/$DATA_DIR yes

# clean out old files
clean_src

# copy over files
mkdir ${PKG_SOURCE_DIR}
unzip files/$DATA_DIR -d ${PKG_SOURCE_DIR}
checkrc $? "unpacking data directory"

# build
build_rpm

# publish
publish_rpm

