#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

function usage() {
  echo "Usage: $0 <setup|build>"
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

case "$1" in

  setup)

    rm -rf proj-svn
    svn co ${proj_svn}/${proj_version}/proj proj-svn
    if [ ! -f ${buildroot}/${proj_nad} ]; then
      curl http://download.osgeo.org/proj/${proj_nad} > ${buildroot}/${proj_nad}
    fi
    cd proj-svn/nad
    unzip -o ${buildroot}/${proj_nad}
    ;;


  build)

    if [ -d proj-svn ]; then
      cd proj-svn
    fi

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
    rm -f ~/Sites/proj-osx.zip
    zip -r9 ~/Sites/proj-osx.zip *
    ;;

  *)
    usage
    ;;


esac

exit 0
    
