#!/bin/bash

. functions

build_info

VERSION=1.10.2
PGADMIN=pgadmin3-$VERSION

# grab files
get_file http://wwwmaster.postgresql.org/redir/333/h/pgadmin3/release/v$VERSION/src/$PGADMIN.tar.gz

# clean out old sources
pushd pgadmin3
ls | grep -v debian | xargs rm -rf
popd

# unpack sources
rm -rf $PGADMIN
tar xzvf files/$PGADMIN.tar.gz
mv $PGADMIN/* pgadmin3
checkrc $? "unpacking pgadmin sources"
rmdir $PGADMIN 

# build
build_deb pgadmin3

# publish
pubish_deb pgadmin3
