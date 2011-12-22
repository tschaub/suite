#!/bin/bash

# load common functions
. "$( cd "$( dirname "$0" )" && pwd )"/functions

set -x
set -e 

DIST_PATH=`init_dist_path`
MVN_SETTINGS=`init_mvn_repo $DIST_PATH`

last_rev=`get_last_built_rev geotools`
echo "last built revision of geotools = $last_rev"

pushd repo/geoserver/externals/geotools

curr_rev=`get_rev .`
echo "current revision of geotools = $last_rev"

if [ "$curr_rev" != "$last_rev" ]; then
  # do the build
  echo "building geotools at revision $curr_rev"
  $MVN -s $MVN_SETTINGS clean install -Dall -DskipTests
fi

popd

set_last_built_rev geotools $curr_rev
