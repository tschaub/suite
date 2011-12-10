#!/bin/bash

#
# Utility function to check return values on commands
#
function checkrv {
  if [ $1 -gt 0 ]; then
    echo "$2 failed with return value $1"
    exit 1
  else
    echo "$2 succeeded return value $1"
  fi
}

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

  $MVN -s $MVN_SETTINGS -P $profile -o assembly:attached
  checkrv $? "maven assembly ($profile profile)"
}

#
# function to copy over build artifacts
# copy_artifacts <alias> [profile]
#
function copy_artifacts {
  local aliaas=$1
  local prefix=""
  local counter=0

  if [ ! -z $2 ]; then
    prefix=-$2
  fi

  pushd target/$2
  for x in $artifacts
  do
    src=opengeosuite${prefix}-*-${x}.zip
    if [ -e $f ]; then
       echo "copying $src"
       dst=opengeosuite${prefix}-$revision-${x}.zip
       cp $src $dist/$dst
       ln -sf $dist/$dst $dist/opengeosuite${prefix}-${aliaas}-${x}.zip
       let counter=counter+1
    fi
  
    src=opengeosuite${prefix}-*-${x}.tar.gz
    if [ -e $src ]; then
      echo "copying $src"
      dst=opengeosuite${prefix}-$revision-${x}.tar.gz
      cp $src $dist/$dst
      ln -sf $dist/$dst $dist/opengeosuite${prefix}-$revision-${x}.tar.gz
      let counter=counter+1
    fi
  done

  popd

  if [ $counter -eq 0 ]; then
    echo "no artifacts copied"
    exit 1
  fi
}

set -x

if [ -z "$DIST_PATH" ]; then
  DIST_PATH="latest"
fi

ALIAS=$REV
if [ "$ALIAS" == "HEAD" ]; then
  ALIAS="latest"
fi

dist=/var/www/suite/$DIST_PATH
if [ ! -e $dist ]; then
  mkdir -p $dist
fi
echo "dist: $dist"

artifacts="bin win mac ext war war-geoserver war-geoexplorer war-geoeditor war-geowebcache war-geoserver-jboss doc analytics control-flow importer readme dashboard-win32 dashboard-lin32 dashboard-lin64 dashboard-osx pgadmin-postgis data-dir"

# set up the maven repository for this particular branch/tag/etc...
MVN_SETTINGS_TEMPLATE=`pwd`/repo/build/settings.xml
pushd maven

# TODO: remove teh maven repo logic and just use a single maven repo
MVN_REPO=latest
if [ ! -d $MVN_REPO ]; then
  echo "Creating new maven repository at `pwd`/$MVN_REPO"
  mkdir -p $MVN_REPO
  sed "s#@PATH@#`pwd`/$MVN_REPO/repo#g" $MVN_SETTINGS_TEMPLATE | sed 's#<\!--\(localRepository>.*</localRepository\)-->#<\1>#g' > $MVN_REPO/settings.xml
  cp -R repo-template $MVN_REPO/repo
fi
popd

MVN_SETTINGS=`pwd`/maven/$MVN_REPO/settings.xml
export MAVEN_OPTS=-Xmx256m

# checkout the requested revision to build
cd repo
git checkout $REV
git pull origin $REV

# extract the revision number
revision=`git log --format=format:%H | head -n 1`
if [ "x$revision" == "x" ]; then
  echo "failed to get revision number from git info"
  exit 1
fi

# only use first seven chars
revision=${revision:0:7}

echo "building $revision ($REV) with maven settings $MVN_SETTINGS"

# perform a full build
$MVN -s $MVN_SETTINGS -Dfull -Dmvn.exec=$MVN -Dmvn.settings=$MVN_SETTINGS -Dbuild.revision=$revision -Dbuild.date=$BUILD_ID $BUILD_FLAGS clean install
checkrv $? "maven install"

$MVN -o -s $MVN_SETTINGS assembly:attached
checkrv $? "maven assembly"

$MVN -s $MVN_SETTINGS -Dmvn.exec=$MVN -Dmvn.settings=$MVN_SETTINGS deploy -DskipTests
checkrv $? "maven deploy"

# build with the enterprise profile
profile_rebuild ee

# build with the cloud profile
#profile_rebuild cloud

# copy the new artifacts into place
copy_artifacts $ALIAS
copy_artifacts $ALIAS ee
#copy_artifacts cloud


# copy the dashboard artifacts into place
pushd $dist
for f in `ls opengeosuite-*-dashboard-*.zip`; do
  f2=$(echo $f|sed 's/opengeosuite-//g'|sed 's/-dashboard//g'|sed 's/^/dashboard-/g') 
  mv $f $f2
done

for x in $artifacts; do
  ls -t | grep "opengeosuite-.*-$x.zip" | tail -n +7 | xargs rm -f
  ls -t | grep "opengeosuite-.*-$x.tar.gz" | tail -n +7 | xargs rm -f
done
for x in win32 lin32 lin64 osx; do
  ls -t | grep "dashboard-.*-$x.zip" | tail -n +7 | xargs rm -f
done
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

