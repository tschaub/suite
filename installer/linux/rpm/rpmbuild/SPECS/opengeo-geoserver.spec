Name: opengeo-geoserver
Version: 2.4.5
Release: 1
Summary: High performance, standards-compliant map and geospatial data server.
Group: Applications/Engineering
License: see http://geoserver.org
Requires(post): bash
Requires(preun): bash

Requires:  unzip, java-1.6.0-openjdk, opengeo-jai, opengeo-suite-data >= 2.4.1, gdal == 1.8.1
Patch: geoserver_webxml.patch
%if 0%{?centos} == 6
Requires: tomcat6
%define TOMCAT tomcat6
%else
Requires: tomcat5
%define TOMCAT tomcat5
%endif
%define TOMCAT_HOME /var/lib/%{TOMCAT}
%define WEBAPPS %{TOMCAT_HOME}/webapps

%define _rpmdir ../
%define _rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm
%define _unpackaged_files_terminate_build 0

%description
GeoServer is an open source software server written in Java that allows users 
to share and edit geospatial data. Designed for interoperability, it 
publishes data from any major spatial data source using open standards such as 
Web Features Server (WFS), Web Map Server (WMS), and Web Coverage Server 
(WCS).  This version of GeoServer is enhanced and designed for use with the 
OpenGeo Suite.

%prep
        
   pushd $RPM_SOURCE_DIR/opengeo-geoserver
   unzip geoserver.war -d geoserver
   cd geoserver
%patch -p1
   zip -r ../geoserver.zip *
   cd ..
   rm -rf geoserver
   mv geoserver.zip geoserver.war
   popd

%install
   rm -rf $RPM_BUILD_ROOT
   mkdir -p $RPM_BUILD_ROOT%{WEBAPPS}
   cp -rp  $RPM_SOURCE_DIR/opengeo-geoserver/geoserver.war  $RPM_BUILD_ROOT%{WEBAPPS}
   mkdir -p $RPM_BUILD_ROOT/usr/share/opengeo-suite
   cp -rp $RPM_SOURCE_DIR/scripts/geoserver-setup.sh $RPM_BUILD_ROOT/usr/share/opengeo-suite/.

%post
   if [ ! -e %{TOMCAT_HOME}/%{TOMCAT}.original-settings ]; then
      cp  /etc/sysconfig/%{TOMCAT} %{TOMCAT_HOME}/%{TOMCAT}.original-settings
      cat << EOF >> /etc/sysconfig/%{TOMCAT}
JAVA_OPTS="-Djava.awt.headless=true -Xms256m -Xmx768m -Xrs -XX:PerfDataSamplingInterval=500 -XX:MaxPermSize=128m"
GEOEXPLORER_DATA="/usr/share/opengeo-suite-data/geoexplorer_data"
EOF
   fi

   WEBAPPS=%{WEBAPPS}
   APP=$WEBAPPS/geoserver
   TMP=/tmp/opengeo-geoserver

   if [ -d $APP ]; then
     # upgrade, perserve the old web.xml
     mkdir $TMP
     cp $APP/WEB-INF/web.xml $TMP

     rm -rf $APP
   fi

   # unpack the war
   unzip  $APP.war -d $APP > /dev/null 2>&1

   if [ -e $TMP/web.xml ]; then
     cp $TMP/web.xml $APP/WEB-INF
     rm -rf $TMP
   fi
   
   if [ -e /usr/lib/gdal.jar ]; then
     cp /usr/lib/gdal.jar $APP/WEB-INF/lib/gdal-1.8.1.jar
   elif [ -e /usr/lib64/gdal.jar ]; then
     cp /usr/lib64/gdal.jar $APP/WEB-INF/lib/gdal-1.8.1.jar
   else
     echo ""
     echo "/usr/lib/gdal.jar not found, geoserver extended raster support will be disabled"
     echo ""
   fi

   chown tomcat %{WEBAPPS}/*.war
   chkconfig %{TOMCAT} on
   service %{TOMCAT} restart

   echo ""
   echo "NOTICE: Please run /usr/share/opengeo-suite/geoserver-setup.sh to complete this installation."
   echo ""

%preun
   APP=%{WEBAPPS}/geoserver

   # $1 == 1 means upgrade, on upgrade don't remove webapp as we want to 
   # preserve certain files, namely web.xml
   if [ "$1" == "0" ]; then

     if [ -e $APP ]; then
       service %{TOMCAT} stop
       rm -rf  $APP.war $APP
     fi

     service %{TOMCAT} restart
   fi

%postun
# remove files
# remove users

%clean

%files
%defattr(-,root,root,-)
%{WEBAPPS}/geoserver.war
/usr/share/opengeo-suite/geoserver-setup.sh

