# Where do we build into (our --prefix)
buildroot=/c/build/
export buildroot
webroot=/c/build/web/
gtkroot=/c/opt/gtk+-bundle_2.16.6

# Versions we are going to continuously integrate...
geos_version=3.3.1
postgis_version=1.5.3
proj_version=4.7.0
pgsql_version=8.4.9
libxml2_version=2.7.6

# Special binaries
proj_nad=proj-datumgrid-1.5.zip

# Standard paths
geos_svn=http://svn.osgeo.org/geos/branches
postgis_svn=http://svn.osgeo.org/postgis/branches
proj_svn=http://svn.osgeo.org/metacrs/proj/branches

# Ensure the buildroot is ready
if [ ! -d $buildroot ]; then
  mkdir $buildroot
fi

# Ensure the local build dir is ready
if [ ! -d build ]; then
  mkdir build
fi

# setup proper gnu environemnt
source /etc/profile
cd $WORKSPACE

# load common functions
source functions
