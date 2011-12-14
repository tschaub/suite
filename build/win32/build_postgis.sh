set -e
set -x

# load version info and utility functions
source hudson_config.sh

POSTGIS=postgis-$postgis_version
get_file http://www.postgis.org/download/$POSTGIS.tar.gz

if [ -d build/$POSTGIS ]; then
  rm -rf build/$POSTGIS
fi

tar xzvf files/$POSTGIS.tar.gz -C build
checkrc $? "unpacking $POSTGIS"

pushd build/$POSTGIS

./configure --prefix=${buildroot}/postgis --with-xml2config=${buildroot}/libxml2/bin/xml2-config --with-pgconfig=${buildroot}/pgsql/bin/pg_config --with-geosconfig=${buildroot}/geos/bin/geos-config --with-projdir=${buildroot}/proj --with-gui
checkrc $? "PostGIS configure"

export PATH=${buildroot}/pgsql/bin:$PATH
make clean && make 
checkrc $? "PostGIS build"

rm -rf ${buildroot}/postgis
mkdir ${buildroot}/postgis
#make DESTDIR=${buildroot}/postgis install
make install
checkrc $? "PostGIS install"

popd

