# Where do we build into (our --prefix)
buildroot=$HOME/buildroot/
webroot=/var/www/htdocs
export buildroot

# Versions we are going to continuously integrate...
gdal_version=1.8.1
geos_version=3.3.1
postgis_version=1.5.3
proj_version=4.7.0
pgsql_version=8.4.9-1

# Special binaries
proj_nad=proj-datumgrid-1.5.zip

# Standard paths
gdal_url=http://download.osgeo.org/gdal/gdal-${gdal_version}.tar.gz
geos_url=http://download.osgeo.org/geos/geos-${geos_version}.tar.bz2
postgis_url=http://www.postgis.org/download/postgis-${postgis_version}.tar.gz
proj_url=http://download.osgeo.org/proj/proj-${proj_version}.tar.gz
edb_zip=postgresql-${pgsql_version}-osx-binaries.zip
edb_url=http://get.enterprisedb.com/postgresql/${edb_zip}

# Ensure the buildroot is ready
if [ ! -d $buildroot ]; then
  mkdir $buildroot
fi

function checkrv {
  if [ $1 -gt 0 ]; then
    echo "$2 failed with return value $1"
    exit 1
  else
    echo "$2 succeeded with return value $1"
  fi
}

# get_file <url> [overwrite]
function get_file() {
  local url=$1
  local file=`echo $url | sed 's#http://##g' | xargs basename`

  if [ ! -d files ]; then
     mkdir files
     checkrv $? "mkdir files"
  fi

  if [ "$2" != "" ] ||  [ ! -e files/$file ]; then
     curl -O $url
     checkrv $? "downloading $url"

     mv $file files
     checkrv $? "mv $file files"
  fi
}
