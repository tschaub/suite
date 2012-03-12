#!/bin/bash

. functions

build_info

# grab files
DATA_DIR=opengeosuite-$REV-data-dir.zip
get_file $BUILDS/$DIST_PATH/$REV/$DATA_DIR yes

# clean out old files
rm -rf opengeo-suite-data/data_dir
unzip files/$DATA_DIR -d opengeo-suite-data
checkrc $? "unpacking data directory"

# build
build_deb opengeo-suite-data

# publish
publish_deb opengeo-suite-data
