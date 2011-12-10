#!/bin/bash

# This script is run by the Hudson OSX installer job.  It is not meant 
# to be run outside Hudson's environment.
#
# This script runs the assemble_installer.sh script, copies the resulting
# binary to a more explicitly named file, creates latest links for trunk
# builds, and cleans up a bit.
#
# This process is bootstrapped in the Hudson jobs build script with the 
# following (DIST_PATH and REVISION are job parameters):
#
#     cd repo/installer/mac
#     bash hudson_installer_job.sh $DIST_PATH $REVISION $PROFILE

if [ $# -lt 3 ]; then
  echo "Usage: $0 <dist_path> <revision> <alias> [profile]"
  exit 1
fi

DIST_PATH=$1
REVISION=$2
ALIAS=$3
PROFILE=$4

DIST_DIR=/Library/WebServer/Documents/suite/$DIST_PATH
if [ ! -e $DIST_DIR ]; then
  mkdir -p $DIST_DIR
fi


bash assemble_installer.sh $DIST_PATH $REVISION $PROFILE
if [ $? -gt 0 ]; then
  exit 1
fi

pro=$(echo $PROFILE|sed 's/\(.\{1,\}\)/-\1/g')
CUR_FILE=${DIST_DIR}/OpenGeoSuite${pro}-${REVISION}-b${BUILD_NUMBER}.dmg
BUILD_FILE=`ls OpenGeoSuite*.dmg`

# move to dist dir
if [ -f $BUILD_FILE ]; then
  mv $BUILD_FILE $CUR_FILE
  md5 $CUR_FILE > ${CUR_FILE}.md5
else
  exit 1
fi

# Remove old versions
find $DIST_DIR -maxdepth 1 -name 'OpenGeoSuite*.dmg' -mtime +6 -exec rm {} \;
find $DIST_DIR -maxdepth 1 -name 'OpenGeoSuite*.md5' -mtime +6 -exec rm {} \;

# Remove old symlinks
find $DIST_DIR -maxdepth 1 -name "OpenGeoSuite${pro}-${ALIAS}.dmg" -type l -exec rm {} \;

# Symlink new version
ln -s $CUR_FILE $DIST_DIR/OpenGeoSuite${pro}-${ALIAS}.dmg
