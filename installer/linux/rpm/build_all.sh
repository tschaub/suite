#!/usr/bin/env bash

. functions

# Clean out last night's nightly build if we're building into unstable
if [ `uname -m` == "i686" ]; then
   ARCH="i386"
elif [ `uname -m` == "x86_64"]; then
   ARCH="x86_64"
fi

# TODO: Make the distro and version dynamic
if [ "$REPO" == "unstable" ]; then
   ssh -i ~/.ssh/id_rsa_apt -p 7777 apt@apt.opengeo.org "./yum/clear_repo.sh $REPO centos/5 $ARCH"
   checkrc $? "remote clean"
   ssh -i ~/.ssh/id_rsa_apt -p 7777 apt@apt.opengeo.org "profile=ee ./yum/clear_repo.sh $REPO centos/5 $ARCH"
   checkrc $? "remote clean ee"
fi
