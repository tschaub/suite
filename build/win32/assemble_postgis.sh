set -e
set -x

# load version info and utility functions
source hudson_config.sh

ROOT=${buildroot}/postgis-win
BIN=${ROOT}/pgsql/bin
LIB=${ROOT}/pgsql/lib
CONTRIB=${ROOT}/pgsql/share/contrib

PGSQL_BIN=postgresql-$pgsql_version-1-windows-binaries.zip
get_file http://downloads.enterprisedb.com/postgresql/$PGSQL_BIN
checkrc $? "$PGSQL_BIN download"

if [ -e $ROOT ]; then
  rm -rf $ROOT
fi
mkdir $ROOT

unzip -d $ROOT files/$PGSQL_BIN
checkrc $? "$PGSQL_BIN unzip"

PGSQL_BIN=${buildroot}/pgsql/bin
PGSQL_LIB=${buildroot}/pgsql/lib
PGSQL_CONTRIB=${buildroot}/pgsql/share/contrib

pushd $PGSQL_BIN
cp shp2pgsql* $BIN
cp pgsql2shp* $BIN
checkrc $? "Copy postgis binaries"
popd

pushd $PGSQL_LIB
cp postgis*.dll $LIB
checkrc $? "Copy postgis libs"
popd

pushd $PGSQL_CONTRIB
cp -R postgis-* $CONTRIB
checkrc $? "Copy postgis contrib"
popd

pushd $buildroot/proj/bin
cp libproj*.dll $BIN
checkrc $? "Copy proj libs"
popd

pushd $buildroot/geos/bin
cp libgeos*.dll $BIN
checkrc $? "Copy geos libs"
popd

pushd $gtkroot/lib
cp -R gtk-2.0 $ROOT/pgsql/lib 
cp -R glib-2.0 $ROOT/pgsql/lib
checkrc $? "Copy gtk libs"
popd
