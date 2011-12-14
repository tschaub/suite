set -e
set -x

# load version info and utility functions
source hudson_config.sh

LIBXML2=libxml2-$libxml2_version
get_file ftp://xmlsoft.org/libxml2/libxml2-$libxml2_version.tar.gz

if [ -d build/$LIBXML2 ]; then
  rm -rf build/$LIBXML2
fi

tar xzvf files/$LIBXML2.tar.gz -C build
checkrc $? "unpacking $LIBXML2"

pushd build/$LIBXML2

# patch testThreads.c
patch --binary -p1 < ../../libxml2.patch

./configure --prefix=${buildroot}/libxml2 --disable-shared CCFLAGS=LDGLAGS="-Wl,-static" CFLAGS=-O2
make clean && make 
checkrc $? "libxml2 build"

rm -rf ${buildroot}/libxml2
mkdir ${buildroot}/libxml2
make install
checkrc $? "libxml2 install"

popd
