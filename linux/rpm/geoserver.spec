Name:           geoserver
Version:        2.0
Release:        3%{?dist}
Summary:        A fast, standards-compliant geographic data server.

Group:          System Environment/Daemons
License:        GPL
URL:            http://geoserver.org/
Source0:        geoserver-%{version}-bin.zip
NoSource:       0 

BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch

BuildRequires:  unzip
Requires:     curl jpackage-utils
# Should also require java-1.6.0-sun...

%description
GeoServer is the reference implementation of the Open Geospatial Consortium (OGC) Web Feature Service (WFS) and Web Coverage Service (WCS) standards, as well as a high performance certified compliant Web Map Service (WMS). GeoServer forms a core component of the Geospatial Web.

%prep
rm -rf $RPM_BUILD_DIR/geoserver-2.0-SNAPSHOT/
unzip -qq %{SOURCE0} -d $RPM_BUILD_DIR
%setup -T -D -n geoserver-2.0-SNAPSHOT

%build
# No build needed, we are starting with the binary build.

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/{%{_initrddir},%{_datadir},%{_localstatedir}}
cp -R $RPM_BUILD_DIR/geoserver-2.0-SNAPSHOT/ $RPM_BUILD_ROOT/%{_datadir}/
mv $RPM_BUILD_DIR/geoserver-2.0-SNAPSHOT/data_dir \
   $RPM_BUILD_ROOT/%{_localstatedir}/geoserver_data

cat > ${RPM_BUILD_ROOT}/%{_initrddir}/geoserver << EOF
#!/bin/sh
#
# chkconfig: 5 75 25
# description: Activate and deactivate GeoServer, a server for edition and \\
# retrieval of raster- and vector-based geographic data.
### BEGIN INIT INFO
# Provides: $geoserver
# Short-Description: Bring up/down GeoServer
# Description: Activate and deactivate GeoServer
### END INIT INFO

if [ -f %{_datadir}/java-utils/java-functions ]; then
    . %{_datadir}/java-utils/java-functions
    set_jvm
    set_javacmd
fi

export JAVA_HOME
export GEOSERVER_HOME=%{_datadir}/geoserver-2.0-SNAPSHOT
export GEOSERVER_DATA_DIR=%{_localstatedir}/geoserver_data
export GEOSERVER_USER=root

case \$1 in
   "start")
       if [ ! -e \$GEOSERVER_DATA_DIR/logs/ ] 
       then
           mkdir \$GEOSERVER_DATA_DIR/logs
           chown \$GEOSERVER_USER \$GEOSERVER_DATA_DIR/logs
       fi

       chown \$GEOSERVER_USER \$GEOSERVER_HOME/logs

       if curl http://localhost:8080 -s > /dev/null;
       then
           echo "GeoServer already running!"
       else
           (su \$GEOSERVER_USER -c "sh \"%{_datadir}/geoserver-2.0-SNAPSHOT/bin/startup.sh\"") 2>&1 \\
               >> \$GEOSERVER_DATA_DIR/logs/service.log &

           until curl http://localhost:8080/ -s > /dev/null;
           do
               sleep 2
               echo -n '.' 
           done
           echo ' Started GeoServer'
       fi;;
   "stop")
       sh %{_datadir}/geoserver-2.0-SNAPSHOT/bin/shutdown.sh;
       while curl http://localhost:8080/ -s > /dev/null;
       do
           sleep 2
           echo -n '.' 
       done
       echo ' Stopped GeoServer' ;;
   * )
      echo "Input must be one of [start|stop]";
esac
EOF
chmod +x ${RPM_BUILD_ROOT}/%{_initrddir}/geoserver

%post
chkconfig --add geoserver

%preun
chkconfig --del geoserver

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{_initrddir}/geoserver
%{_datadir}/geoserver-2.0-SNAPSHOT
%config
%{_localstatedir}/geoserver_data/
%doc

%changelog
* Wed May 13 2009 David Winslow <dwinslow@opengeo.org>
   - Add support for running GeoServer as non-root user
* Sun Apr 05 2009 David Winslow <dwinslow@opengeo.org>
  - Initial packaging, added init script and separated data dir from war 
  installation.
