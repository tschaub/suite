#!/bin/bash

. functions

build_info

function unpack_jars() {
  mkdir tmp
  unzip files/$1 -d tmp
  mv tmp/opengeosuite-*/*.jar $PKG_SOURCE_DIR
  checkrc $? "unpacking jars"
  rm -rf tmp
}

# grab files
ANALYTICS=opengeosuite-ee-$REV-analytics.zip
CFLOW=opengeosuite-$REV-control-flow.zip

get_file $BUILDS/$DIST_PATH/$REV/$ANALYTICS yes
get_file $BUILDS/$DIST_PATH/$REV/$CFLOW yes

# clean out old files
clean_src

# unpack
mkdir $PKG_SOURCE_DIR
unpack_jars $ANALYTICS
unpack_jars $CFLOW

# build
build_rpm

# publish
publish_rpm ee

