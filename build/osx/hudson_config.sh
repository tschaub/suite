# Where do we build into (our --prefix)
buildroot=$HOME/buildroot/

# Versions we are going to continuously integrate...
geos_version=3.2
postgis_version=1.5
proj_version=4.7

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
