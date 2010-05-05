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

# Working directory
pushd ${d}
p=`pwd`
popd


case "$1" in

  setup)

    rm -rf postgis-svn
    svn co ${postgis_svn}/${postgis_version} postgis-svn
    ;;


  build)

    # Download the EDB binaries if necessary
    if [ ! -f ${buildroot}/${edb_zip} ]; then
      curl ${edb_url} > ${buildroot}/${edb_zip}
    fi
    # Clean up and unzip the EDB directory
    if [ -d ${buildroot}/pgsql ]; then
      rm -rf ${buildroot}/pgsql
    fi
    unzip ${buildroot}/${edb_zip} -d ${buildroot}

    # Patch PGXS
    pushd ${buildroot}/pgsql/lib/postgresql/pgxs/src
    patch -p0 < ${p}/pgxs.patch
    popd

    # Copy the Proj libraries into the pgsql build directory
    if [ -d ${buildroot}/proj ]; then
      cp -rf ${buildroot}/proj/* ${buildroot}/pgsql
    else
      exit 1
    fi

    # Copy the GEOS libraries into the pgsql build directory
    if [ -d ${buildroot}/geos ]; then
      cp -rf ${buildroot}/geos/* ${buildroot}/pgsql
    else
      exit 1
    fi

    # Check for the existence of the GTK environment
    if [ ! -d $HOME/gtk ]; then
      exit 1
    fi
    if [ ! -d $HOME/.local ]; then
      exit 1
    fi

    # Set up paths necessary to build
    export PATH=${buildroot}/pgsql/bin:${HOME}/gtk/inst/bin:${HOME}/.local/bin:${PATH}
    export DYLD_LIBRARY_PATH=${buildroot}/pgsql/lib

    # Enter the svn directory if it's there.
    if [ -d postgis-svn ]; then
      cd postgis-svn
    fi

    # Configure PostGIS
    ./autogen.sh
    export CC=gcc-4.0 
    export CFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4" 
    export CXX=g++-4.0 
    export CXXFLAGS="-O2 -arch i386 -arch ppc -mmacosx-version-min=10.4" 
    ./configure \
      --with-pgconfig=${buildroot}/pgsql/bin/pg_config \
      --with-geosconfig=${buildroot}/pgsql/bin/geos-config \
      --with-projdir=${buildroot}/pgsql \
      --with-xml2config=/usr/bin/xml2-config \
      --disable-dependency-tracking 

    # Build PostGIS
    make clean && make && make install

    # Re-Configure without ppc arch so we can link to GTK
    export CFLAGS="-O2 -arch i386 -mmacosx-version-min=10.4" 
    export CXXFLAGS="-O2 -arch i386 -mmacosx-version-min=10.4" 

    # Re-configure with GTK on the path
    jhbuild run \ 
    ./configure \
      --with-pgconfig=${buildroot}/pgsql/bin/pg_config \
      --with-geosconfig=${buildroot}/pgsql/bin/geos-config \
      --with-projdir=${buildroot}/pgsql \
      --with-xml2config=/usr/bin/xml2-config \
      --with-gui \
      --disable-dependency-tracking

    pushd liblwgeom
    jhbuild run make clean all
    popd
    pushd loader
    jhbuild run make clean all
    cp -f shp2pgsql-gui ${buildroot}/pgsql/bin
    popd

    # Bundle the pgShapeLoader.app
    cd ..
    pushd shp2pgsql-ige-mac-bundle
    jhbuild run ige-mac-bundler ShapeLoader.bundle
    popd

    # Zip up the results and put on the web
    pushd ${buildroot}
    rm -f ~/Sites/postgis-osx.zip
    zip -r9 ~/Sites/postgis-osx.zip pgsql
    popd

    ;;


  *)
    usage
    ;;


esac

exit 0
    
