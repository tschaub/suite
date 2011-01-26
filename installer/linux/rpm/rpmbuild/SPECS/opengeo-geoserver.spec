Name: opengeo-geoserver
Version: 2.3.0
Release: 1
Summary: High performance, standards-compliant map and geospatial data server.
Group: Applications/Engineering
License: see http://geoserver.org
Requires(post): bash
Requires(preun): bash
Requires:  tomcat5, java-1.6.0-openjdk, opengeo-jai, opengeo-suite-data
Patch: geoserver_webxml.patch

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
        mkdir -p $RPM_BUILD_ROOT/var/lib/tomcat5/webapps/
        #unzip $RPM_SOURCE_DIR/opengeo-geoserver/geoserver.war -d $RPM_BUILD_ROOT/geoserver
        #cp $RPM_SOURCE_DIR/opengeo-geoserver/debian/web.xml $RPM_BUILD_ROOT/geoserver/WEB-INF/web.xml
        #( cd  $RPM_BUILD_ROOT/geoserver ; zip ../geoserver.zip * -r ; cd ..)
        cp -rp  $RPM_SOURCE_DIR/opengeo-geoserver/geoserver.war  $RPM_BUILD_ROOT/var/lib/tomcat5/webapps
        #rm -rf  $RPM_BUILD_ROOT/geoserver  $RPM_BUILD_ROOT/geoserver.zip
        mkdir -p $RPM_BUILD_ROOT/usr/share/opengeo-suite
		cp -rp $RPM_SOURCE_DIR/scripts/geoserver-setup.sh $RPM_BUILD_ROOT/usr/share/opengeo-suite/.

%post
if [ ! -e /var/lib/tomcat5/tomcat5.original-settings ]; then

cp  /etc/sysconfig/tomcat5 /var/lib/tomcat5/tomcat5.original-settings
cat << EOF >> /etc/sysconfig/tomcat5
JAVA_OPTS="-Djava.awt.headless=true -Xms256m -Xmx768m -Xrs -XX:PerfDataSamplingInterval=500 -XX:MaxPermSize=128m"
GEOEXPLORER_DATA="/usr/share/opengeo-suite-data/geoexplorer_data"
EOF

fi
	chown tomcat. /var/lib/tomcat5/webapps/*.war
	chkconfig tomcat5 on
	service tomcat5 restart

    echo ""
    echo "NOTICE: Please run /usr/share/opengeo-suite/geoserver-setup.sh to complete this installation."
    echo ""

%preun
       if [ -e /var/lib/tomcat5/webapps/geoserver ]; then
                service tomcat5 stop
                rm -rf  /var/lib/tomcat5/webapps/geoserver.war /var/lib/tomcat5/webapps/geoserver
        fi
        service tomcat5 restart

%postun
# remove files
# remove users


%clean

%files
%defattr(-,root,root,-)
%dir "/var/lib/tomcat5/webapps/*"
/usr/share/opengeo-suite/geoserver-setup.sh

