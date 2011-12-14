set -e
set -x

# load version info and utility functions
source hudson_config.sh

GEOS=geos-$geos_version
get_file http://download.osgeo.org/geos/$GEOS.tar.bz2

if [ -d build/$GEOS ]; then
  rm -rf build/$GEOS
fi

tar xjvf files/$GEOS.tar.bz2 -C build
checkrc $? "unpacking $GEOS"

pushd build/$GEOS

./configure --prefix=${buildroot}/geos
make clean && make 
checkrc $? "GEOS build"

rm -rf ${buildroot}/geos
mkdir ${buildroot}/geos
make install
checkrc $? "GEOS install"

popd
