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
ANALYTICS=opengeosuite-ee-$BRANCH-$REV-analytics.zip
IMPORTER=opengeosuite-ee-$BRANCH-$REV-importer.zip
CFLOW=opengeosuite-$BRANCH-$REV-controlflow.zip

get_file $BUILDS/$REPO_PATH/$ANALYTICS yes
get_file $BUILDS/$REPO_PATH/$IMPORTER yes
get_file $BUILDS/$REPO_PATH/$CFLOW yes

unpack_jars files/$ANALYTICS
unpack_jars files/$IMPORTER
unpack_jars files/$CFLOW

# clean out old files
rm -rf opengeo-suite-ee/*.jar

# unpack

# build
build_deb opengeo-suite-ee

# publish
publish_deb opengeo-suite-ee ee
