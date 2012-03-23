#!/usr/bin/env bash

. functions

# source distribution information
. /etc/lsb-release

# Clean out last night's nightly build if we're building into unstable

if [ `uname -m` == "i386" ]; then
   ARCH="i386"
elif [ `uname -m` == "x86_64"]; then
   ARCH="amd64"
fi

if [ "$REPO" == "unstable" ]; then
   ssh -i ~/.ssh/id_rsa_apt -p 7777 apt@apt.opengeo.org "ARCH=$ARCH ./apt/clear_repo.sh $REPO $DISTRIB_CODENAME"
   checkrc $? "remote clean"
   ssh -i ~/.ssh/id_rsa_apt -p 7777 apt@apt.opengeo.org "ARCH=$ARCH ./apt/clear_repo.sh $REPO $DISTRIB_CODENAME ee"
   checkrc $? "remote clean ee"
fi
