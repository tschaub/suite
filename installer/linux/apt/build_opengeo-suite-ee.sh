#!/bin/bash

. functions

build_info

function unpack_jars() {
  mkdir tmp
  unzip files/$1 -d tmp
  mv tmp/opengeosuite-*/*.jar opengeo-suite-ee
  checkrc $? "unpacking jars"
  rm -rf tmp
}

# grab files
ANALYTICS=opengeosuite-ee-$REV-analytics.zip
CFLOW=opengeosuite-$REV-control-flow.zip
DATA_DIR=opengeosuite-$REV-data-dir.zip

get_file $BUILDS/$DIST_PATH/$REV/$ANALYTICS yes
get_file $BUILDS/$DIST_PATH/$REV/$CFLOW yes
get_file $BUILDS/$DIST_PATH/$REV/$DATA_DIR yes

# clean out old files
rm -rf opengeo-suite-ee/*.jar
rm -rf opengeo-suite-ee/*.properties

# unpack jars
unpack_jars $ANALYTICS
unpack_jars $CFLOW

# copy over analytics files
mkdir tmp
unzip files/$DATA_DIR -d tmp
cp tmp/data_dir/monitoring/* opengeo-suite-ee
rm -rf tmp

# build
build_deb opengeo-suite-ee

# publish
publish_deb opengeo-suite-ee ee
