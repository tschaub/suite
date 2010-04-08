Pre-built Binary Files
----------------------

The platform-dependent parts of the Suite currently require pre-built
binaries to be brought into the assembly process. 

 * GDAL libraries 
 * PostgreSQL binaries
 * PostGIS binaries
 * Windows JRE

The binaries are stored on data.opengeo.org:

 http://data.opengeo.org/suite/
 arachnia:/sites/data.opengeo.org/htdocs/suite/

The naming scheme for zip files includes version number, build number and
platform, for example:

 * suite-gdal-1.4.1-1-win.zip
 * suite-gdal-1.4.1-1-osx.zip
 * suite-gdal-1.4.1-1-lin.zip
 * pgsql-8.4.3-postgis-1.5.1-1-win.zip
 * pgsql-8.4.3-postgis-1.5.1-1-osx.zip

Inside the zip file there will be no "containing" root directory, so 
for example, the structure of gdal will not be ./gdal/gdal.dll it 
will just be ./gdal.dll. Similarly you will not see ./pgsql/bin, but
just ./bin in the pgsql zip files.

PostGIS/PostgreSQL
------------------

PostGIS/PostgreSQL binaries will be delivered in a single unified zip file,
with no directory prefix, so expect the following directories in the file:

 ./bin
 ./lib
 ./share
 ./etc

In OS/X the user applications (pgShapeLoader.app and pgAdminIII.app) will be
stored under the root and contain all their dependencies, so they can be
relocated into /Applications if so desired.

In Windows, the user applications shp2pgsql-gui.exe and pgadmin.exe will be in 
the ./bin directory alongside their shared dependencies, and should be 
addressed with shortcuts, not relocated.



