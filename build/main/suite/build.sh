#!/bin/bash

# load common functions
. "$( cd "$( dirname "$0" )" && pwd )"/functions 

#
# function to rebuild with a specific profile
# profile_rebuild <profile>
#
function profile_rebuild {
  local profile=$1

  pushd geoserver/web/app
  $MVN -s $MVN_SETTINGS -o clean install -P $profile -Dbuild.revision=$revision -Dbuild.date=$BUILD_ID
  checkrv $? "maven clean install geoserver/web/app ($profile profile)"
  popd

  pushd dashboard
  $MVN -s $MVN_SETTINGS -o clean install -P $profile -Dbuild.revision=$revision -Dbuild.date=$BUILD_ID
  checkrv $? "maven clean install dashboard ($profile profile)"
  popd

  $MVN -s $MVN_SETTINGS -P $profile -o assembly:attached -Dbuild.revision=$revision
  checkrv $? "maven assembly ($profile profile)"
}

set -x

DIST_PATH=`init_dist_path $DIST_PATH`

ALIAS=$REV
if [ "$ALIAS" == "HEAD" ]; then
  ALIAS="latest"
fi

# set up the maven repository for this particular branch/tag/etc...
#TODO: fix dist_path logic and how it relates to maven repo, etc...
MVN_SETTINGS=`init_mvn_repo latest`
export MAVEN_OPTS=-Xmx256m

# checkout the requested revision to build
cd repo
if [ ! -z $REV ]; then
  git checkout $REV

  # if this rev is a tag don't pull
  if [ "$( git tag | grep $REV )" != $REV ]; then
     git pull origin $REV
  fi

  git submodule update --init --recursive
fi

# extract the revision number
revision=`get_rev .`

# only use first seven chars
revision=${revision:0:7}

echo "building $revision ($REV) with maven settings $MVN_SETTINGS"

dist=/var/www/suite/$DIST_PATH/$revision
if [ ! -e $dist ]; then
  mkdir -p $dist
fi

echo "exporting artifacts to: $dist"

# perform a full build
$MVN -s $MVN_SETTINGS -Dfull -Dmvn.exec=$MVN -Dmvn.settings=$MVN_SETTINGS -Dbuild.revision=$revision -Dbuild.date=$BUILD_ID $BUILD_FLAGS clean install
checkrv $? "maven install"

$MVN -o -s $MVN_SETTINGS assembly:attached -Dbuild.revision=$revision
checkrv $? "maven assembly"

$MVN -s $MVN_SETTINGS -Dmvn.exec=$MVN -Dmvn.settings=$MVN_SETTINGS deploy -DskipTests
checkrv $? "maven deploy"

# build with the enterprise profile
profile_rebuild ee

# copy the new artifacts into place
cp target/*.zip target/ee/*.zip $dist

# alias the artifacts if necessary
pushd $dist
for f in `ls *.zip`; do
  f2=$( echo $f | sed "s/$revision/$ALIAS/g" )
  ln -sf $f $f2
done
popd

# alias the entire build
pushd $dist/..
if [ -e $ALIAS ]; then
  unlink $ALIAS
fi
ln -sf $dist $ALIAS
popd

# clean up old artifacts
pushd $dist/..
if [ "$DIST_PATH" == "latest" ]; then
  # keep around last two build
  ls -lt | grep -v "^l" | cut -d ' ' -f 8 | tail -n +3 | xargs rm -rf 
fi
if [ "$DIST_PATH" == "stable" ]; then
  # only keep around builds that are less than 2 weeks old
  find . -type d -mtime +14 -exec rm -f {} \;
fi
popd

# start_remote_job <url> <name> <profile>
function start_remote_job() {
   curl -k --connect-timeout 10 "$1/buildWithParameters?DIST_PATH=${DIST_PATH}&REVISION=${revision}&ALIAS=${ALIAS}&PROFILE=$3"
   checkrv $? "trigger $2 $3 with ${DIST_PATH} r${revision}"
}

# start the build of the OSX installer
start_remote_job http://10.52.11.40:8080/job/osx-installer "osx installer"

# start the build of the OSX installer (ee)
start_remote_job http://10.52.11.40:8080/job/osx-installer "osx installer" ee

# start the build of the Windows installer
start_remote_job http://10.52.11.58:8080/hudson/job/windows-installer "win installer"

# start the build of the Windows installer (ee)
start_remote_job http://10.52.11.58:8080/hudson/job/windows-installer "win installer" ee

# start the build of the Linux32 installer
#start_remote_job http://10.52.11.55:8080/job/linux32-installer "lin32 installer"

# start the build of the Linux64 installer
#start_remote_job http://10.52.11.57:8080/job/linux64-installer "lin64 installer"

# start the build of the 32 bit Ubuntu 10.4 package
#start_remote_job https://packaging-u1040-32.dev.opengeo.org/hudson/job/build "ubuntu 10.4 32 bit"

# start the build of the 64 bit Ubuntu 10.4 package
#start_remote_job https://packaging-u1040-64.dev.opengeo.org/hudson/job/build "ubuntu 10.4 64 bit"

# start the build of the 32 bit CenTOS 5.5 package
#start_remote_job https://packaging-c55-32.dev.opengeo.org/hudson/job/build "CentOS 5.5 32 bit"

# start the build of the 64 bit CenTOS 5.5 package
#start_remote_job https://packaging-c55-64.dev.opengeo.org/hudson/job/build "CentOS 5.5 64 bit"

echo "Done."

