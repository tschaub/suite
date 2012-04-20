OSX Build Scripts
-----------------

  Please see postgis_osx_build.txt for the build requirements in terms of necessary
  software that must be preinstalled on the machine.

hudson_config.sh

  This script contains global configuration information. 

  ${buildroot} is a directory where the built software is 'make install'ed before
  being zipped up. Each script in the chain presumes the previous scripts have
  built software into the buildroot for them to depend on.

hudson_proj.sh <destdir>
hudson_geos.sh <destdir>

  These scripts build the library dependencies and install them in the buildroot. 
  They also zip up the built file and put the zips into the destdir.

hudson_postgis.sh

  This script builds against the EDB binaries. The EDB binaries get unzipped into
  the buildroot and PostGIS is built and installed into that EDB tree. This script
  requires the pre-installation of GTK and jhbuild. See postgis_osx_build.txt.

hudson_bundle.sh <destdir>

  This script bundles the shp2pgsql-gui into a .app package, and zips up the pgsql
  directory from buildroot into the destdir. The srcdir in this case is this 
  directory (build/osx) wherever you happen to have checked it out.

