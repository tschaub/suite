#!/bin/bash

. functions

build_info

# grab files
ANALYTICS=opengeosuite-ee-$BRANCH-$REV-analytics.zip
get_file $BUILDS/$REPO_PATH/$ANALYTICS yes

# clean out old files
rm -rf opengeo-analytics/analytics
mkdir opengeo-analytics/analytics

# unpack
mkdir tmp
unzip files/$ANALYTICS -d tmp
mv tmp/opengeosuite-*/*.jar opengeo-analytics/analytics
checkrc $? "unpacking analytics jars"
rm -rf tmp

# build
build_deb opengeo-analytics

# publish
publish_deb opengeo-analytics ee
