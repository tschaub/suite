set -e
set -x

# load version info and utility functions
source hudson_config.sh

PGSQL=postgresql-$pgsql_version
PGSQL_BIN=$PGSQL-windows-binaries.zip
#get_file http://downloads.enterprisedb.com/postgresql/$PGSQL_BIN
get_file http://ftp.postgresql.org/pub/source/v$pgsql_version/$PGSQL.tar.gz

if [ -d build/$PGSQL ]; then
  rm -rf build/$PGSQL
fi

#unzip -d build/$PGSQL files/$PGSQL_BIN
tar xzvf files/$PGSQL.tar.gz -C build
checkrc $? "unpacking $PGSQL"

pushd build/$PGSQL

./configure --prefix=${buildroot}/pgsql
checkrc $? "PostgreSQL configure"

make
checkrc $? "PostgreSQL make"

rm -rf ${buildroot}/pgsql
#cp -R pgsql ${buildroot}
make install
checkrc $? "PostgreSQL install"

popd
