#!/usr/bin/env bash

. functions

# source distribution information
. /etc/lsb-release

# Clean out last night's nightly build if we're building into unstable
ARCH=`uname -m`

# TODO: Make the distro and version dynamic
if [ "$REPO" == "unstable" ]; then
   ssh -i ~/.ssh/id_rsa_apt -p 7777 apt@apt.opengeo.org "./yum/clear_repo.sh $REPO centos/5 $ARCH"
   checkrc $? "remote clean"
   ssh -i ~/.ssh/id_rsa_apt -p 7777 apt@apt.opengeo.org "profile=ee ./yum/clear_repo.sh $REPO centos/5 $ARCH"
   checkrc $? "remote clean ee"
fi
