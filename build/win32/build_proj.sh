# Load version information and utility functions
source hudson_config.sh

PROJ=proj-$proj_version
PROJ_DATUMGRID=proj-datumgrid-1.5

# Fetch sources and NAD grids files
get_file http://download.osgeo.org/proj/$PROJ.tar.gz
get_file http://download.osgeo.org/proj/$PROJ_DATUMGRID.zip

if [ -d build/$PROJ ]; then
  rm -rf build/$PROJ
fi

# unpack proj sources
tar xzvf files/$PROJ.tar.gz -C build
checkrc $? "unpacking $PROJ"

# unpack the NAD grid files
unzip -d build/$PROJ/nad files/$PROJ_DATUMGRID.zip
checkrc $? "unpacking $PROJ_DATUM"

pushd build/$PROJ

# Patch a current build issue with MinGW and proj
patch --binary -p0 < ../../proj_mutex.patch
checkrc $? "Proj mutex patch"

# Patch the nad install file
patch --binary -p0 < ../../proj_makefile.patch
checkrc $? "Proj makefile patch"

# Build proj
./configure --prefix=${buildroot}/proj --enable-shared --disable-static
make clean all
checkrv $? "Proj build"

# Clean the install directory
rm -rf ${buildroot}/proj
mkdir ${buildroot}/proj
make install
checkrc $? "Proj install"

popd
