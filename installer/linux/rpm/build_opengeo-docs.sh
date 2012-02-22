#!/bin/bash

. functions

echo $RPM_SOURCE_DIR

# grab files
DOCS=opengeosuite-$REV-doc.zip
get_file $BUILDS/$DIST_PATH/$REV/$DOCS yes

# clean out old files
clean_src

# unpack
unzip files/$DOCS -d $PKG_SOURCE_DIR
checkrc $? "unpacking docs"

# build
build_rpm

# publish
publish_rpm

