#!/bin/bash

# load common functions
. "$( cd "$( dirname "$0" )" && pwd )"/functions 

set -x

if [ "$REV" == "HEAD" ]; then
  REV="latest"
fi

# start_remote_job <url> <name>
function start_remote_job() {
   curl -k --connect-timeout 10 "$1/buildWithParameters?DIST_PATH=${DIST_PATH}&REVISION=${REV}&REPO=${REPO}"
   checkrv $? "trigger $2 with ${DIST_PATH} r${revision}"
}

# start the build of the OSX installer
#start_remote_job http://10.52.11.40:8080/job/osx-installer "osx installer"

# start the build of the OSX installer (ee)
#start_remote_job http://10.52.11.40:8080/job/osx-installer "osx installer" ee

# start the build of the Windows installer
#start_remote_job http://10.52.11.58:8080/hudson/job/windows-installer "win installer"

# start the build of the Windows installer (ee)
#start_remote_job http://10.52.11.58:8080/hudson/job/windows-installer "win installer" ee

# start the build of the 32 bit Ubuntu 10.4 package
start_remote_job https://packaging-u1040-32.dev.opengeo.org/hudson/job/build-all "ubuntu 10.4 32 bit"

# start the build of the 64 bit Ubuntu 10.4 package
start_remote_job https://packaging-u1040-64.dev.opengeo.org/hudson/job/build-all "ubuntu 10.4 64 bit"

# start the build of the 32 bit CenTOS 5.5 package
start_remote_job https://packaging-c55-32.dev.opengeo.org/hudson/job/build-all "CentOS 5.5 32 bit"

# start the build of the 64 bit CenTOS 5.5 package
start_remote_job https://packaging-c55-64.dev.opengeo.org/hudson/job/build-all "CentOS 5.5 64 bit"

echo "Done."

