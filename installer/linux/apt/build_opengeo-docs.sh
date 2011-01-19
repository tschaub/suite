#!/bin/bash

. functions

# grab files
DOCS=opengeosuite-$BRANCH-$REV-doc.zip
get_file $BUILDS/$REPO_PATH/$DOCS

# clean out old files
rm -rf opengeo-docs/docs

# unpack
unzip files/$DOCS -d opengeo-docs
checkrc $? "unpacking docs"
exit 

# build
build_deb opengeo-docs
