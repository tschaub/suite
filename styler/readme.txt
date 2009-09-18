Building
------------------------

In order to user Styler you'll first have to build it.
In order to build it:

sudo easy_install jstools
mkdir script
jsbuild build.cfg -o script

Using
-----------------------

Copy (or link) the entire directory in a place that
in the GeoServer $DATA_DIR/www/styler folder, and then
access it from:
http://host:port/geoserver/www/styler/index.html

In order for styler to work the GeoSErver RESTConfig extension
will have to be installed as well

