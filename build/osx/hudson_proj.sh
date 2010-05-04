#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0 <setup|build>"
}

if [ $# -lt 1 ]; then
  usage;
fi

case "$1" in

  setup)

    rm -rf proj-svn
    svn co ${proj_svn}/${proj_version}/proj proj-svn
    if [ ! -f ${proj_nad} ]; then
      wget http://download.osgeo.org/proj/${proj_nad}
    fi
    cd proj-svn/nad
    unzip -o ../../${proj_nad}
    ;;


  build)

    ./autogen.sh
    CXX=g++-4.0 CC=gcc-4.0 CXXFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4" CFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4" ./configure --prefix=${buildroot}/proj --disable-dependency-tracking
    make clean all
    if [ $rv -gt 0 ]; then
      echo "Proj build failed with return value $rv"
      exit 1
    fi

    rm -rf ${buildroot}/proj
    mkdir ${buildroot}/proj
    make install
    cd ${buildroot}/proj
    rm -f ~/Sites/proj.zip
    zip -r9 ~/Sites/proj.zip *
    ;;

esac

exit 0
    
