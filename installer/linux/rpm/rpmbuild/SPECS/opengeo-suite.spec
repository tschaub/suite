Name: opengeo-suite
Version: 2.4.0
Release: 1
Summary: A full geospatial software stack that allows you to allows you to easily compose, style, and publish data and maps.
Group: Applications/Engineering
License: see http://opengeo.org
Requires(post): bash
Requires(preun): bash
Requires: opengeo-postgis opengeo-geoserver
Patch: geoexplorer_webxml.patch

%define _rpmdir ../
%define _rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm
%define _unpackaged_files_terminate_build 0

%description
The OpenGeo Suite is the complete, OGC standards-compliant web mapping 
platform built on powerful, cutting-edge, open source geospatial 
components.  It is comprised of the following core components:

 * PostGIS
 * GeoServer
 * GeoWebCache
 * OpenLayers
 * GeoExt

Also included are three GeoExt-based web applications:

 * GeoExplorer, for composing and publishing maps
 * Styler, for graphical styling of map layers
 * GeoEditor, for graphical editing of geospatial features

Finally, the OpenGeo Suite contains a Recipe Book for building your 
own web-based mapping applications.


%prep
   pushd $RPM_SOURCE_DIR/opengeo-suite
   unzip geoexplorer.war -d geoexplorer
   cd geoexplorer
%patch -p1
   zip -r ../geoexplorer.zip *
   cd ..
   rm -rf geoexplorer
   mv geoexplorer.zip geoexplorer.war
   popd

%install
   rm -rf $RPM_BUILD_ROOT
   mkdir -p $RPM_BUILD_ROOT/usr/share/opengeo-suite
   mkdir -p $RPM_BUILD_ROOT/var/lib/tomcat5/webapps

   cp -rp $RPM_SOURCE_DIR/opengeo-suite/dashboard.war $RPM_BUILD_ROOT/var/lib/tomcat5/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/geoeditor.war $RPM_BUILD_ROOT/var/lib/tomcat5/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/geowebcache.war $RPM_BUILD_ROOT/var/lib/tomcat5/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/recipes.war $RPM_BUILD_ROOT/var/lib/tomcat5/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/geoexplorer.war $RPM_BUILD_ROOT/var/lib/tomcat5/webapps/.

%post

%preun

  if [ -e /var/lib/tomcat5/webapps/geoexplorer ]; then
     service tomcat5 stop
     rm -rf /var/lib/tomcat5/webapps/recipes /var/lib/tomcat5/webapps/dashboard
     rm -rf /var/lib/tomcat5/webapps/geoeditor /var/lib/tomcat5/webapps/geowebcache
     rm -rf /var/lib/tomcat5/webapps/geoexplorer /var/lib/tomcat5/webapps/geowebcache
     rm -rf /var/lib/tomcat5/webapps/dashboard.war
     rm -rf /var/lib/tomcat5/webapps/geoeditor.war
     rm -rf /var/lib/tomcat5/webapps/geoexplorer.war
     rm -rf /var/lib/tomcat5/webapps/geowebcache.war
     rm -rf /var/lib/tomcat5/webapps/recipes.war
     service tomcat5 start
  fi

%postun

%clean

%files
%defattr(-,root,root,-)
%dir "/var/lib/tomcat5/webapps/*"
