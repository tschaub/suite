set -e
set -x

# load version info and utility functions
source hudson_config.sh

GDAL=gdal-$gdal_version
get_file http://download.osgeo.org/gdal/$GDAL.tar.gz


if [ -d build/$GDAL ]; then
  rm -rf build/$GDAL
fi

tar xzvf files/$GDAL.tar.gz -C build
checkrc $? "unpacking $GDAL"

# Move custom nmake build settings file into place
cp gdal_nmake.opt build/$GDAL/nmake.opt

# get MrSID files
get_file http://data.opengeo.org/suite/Unified_DSDK_8.0_win32-vs10.zip

if [ -d build/mrsid_sdk ]; then
  rm -rf build/mrsid_sdk
fi

if [ -d /c/build/mrsid_sdk ]; then
  rm -rf /c/build/mrsid_sdk
fi

# unpack MrSID files and move them into place
unzip files/Unified_DSDK_8.0_win32-vs10.zip -d build/mrsid_sdk
cp -r build/mrsid_sdk/Raster_DSDK /c/build/mrsid_sdk

# Set some environment variables to make nmake actually work
export INCLUDE="C:\Program Files\Microsoft Visual Studio 10.0\VC\INCLUDE;C:\Program Files\Microsoft SDKs\Windows\v7.0A\include;"
export LIB="C:\Program Files\Microsoft Visual Studio 10.0\VC\LIB;C:\Program Files\Microsoft SDKs\Windows\v7.0A\lib;"
export LIBPATH="C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319;C:\WINDOWS\Microsoft.NET\Framework\v3.5;C:\Program Files\Microsoft Visual Studio 10.0\VC\LIB; "
export PATH="/C/Program Files/Microsoft Visual Studio 10.0/Common7/IDE/":"/C/Program Files/Microsoft Visual Studio 10.0/VC/BIN":"/C/Program Files/Microsoft Visual Studio 10.0/Common7/Tools":"/C/WINDOWS/Microsoft.NET/Framework/v4.0.30319":"/C/WINDOWS/Microsoft.NET/Framework/v3.5":"/C/Program Files/Microsoft Visual Studio 10.0/VC/VCPackages":"/C/Program Files/Microsoft SDKs/Windows/v7.0A/bin/NETFX 4.0 Tools":"/C/Program Files/Microsoft SDKs/Windows/v7.0A/bin":"/C/WINDOWS/system32":"/C/WINDOWS":"/C/WINDOWS\System32\Wbem":$PATH

pushd build/$GDAL

nmake -f makefile.vc

checkrc $? "GDAL build"

rm -rf ${buildroot}/gdal
mkdir ${buildroot}/gdal
nmake -f makefile.vc devinstall
# Install MrSID SDK
cp /c/build/mrsid_sdk/lib/lti_dsdk*.dll ${buildroot}/gdal/bin
checkrc $? "GDAL install"

popd
