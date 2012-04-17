.. _analytics.geolocation:

Geolocation of requests
=======================

Be default, Analytics maintains a list of source IPs of requests, but does not contain the ability to geolocate them and thus display the requests on a map.  To configure this, third-party software will need to be installed on the server where GeoServer is installed.  This section will detail the installation of the `MaxMind GeoIP database <http://www.maxmind.com/app/ip-location>`_.

Installing MaxMind GeoIP database
---------------------------------

Linux / OS X
~~~~~~~~~~~~

.. note:: You will likely need to have elevated privileges in order to accomplish the steps below.

#. Download the GeoIP Cities database to a temporary directory (such as :file:`/tmp`).  The database is available at http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz .

#. Uncompress the downloaded file::
 
      $ tar xvfs GeoLiteCity.dat.gz

#. Move the extracted GeoLiteCity.dat file to the :file:`monitoring` subdirectory of your GeoServer data directory (such as :file:`/data/geoserver_data/monitoring/`)::

      $ mv GeoLiteCity.dat /data/geoserver_data/monitoring/

#. Change ownership on the :file:`GeoLiteCity.dat` file to the owner of the servlet container directory (in this case assumed to be ``tomcat6:tomcat6``::

      $ chown tomcat6:tomcat6 GeoLiteCity.dat

#. Restart GeoServer to persist these configurations.


Windows
~~~~~~~

#. Download the GeoIP Cities database from http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz .

#. Using a program such as `7-zip <http:7-zip.org>`_, uncompress the downloaded file to your Desktop or temporary folder.

#. Copy the resulting :file`GeoLiteCity.dat` file to the :file:`monitoring` subfolder of your GeoServer Data Directory (such as  :file:``C:\\Users\\Administrator\\.opengeo\\data_dir\\monitoring\\``)

#. Restart GeoServer to persist these configurations.
