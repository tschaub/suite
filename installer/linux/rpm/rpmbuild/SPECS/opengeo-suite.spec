Name: opengeo-suite
Version: 2.4.6
Release: 1
Summary: A full geospatial software stack that allows you to allows you to easily compose, style, and publish data and maps.
Group: Applications/Engineering
License: see http://opengeo.org
Requires(post): bash
Requires(preun): bash
Requires: opengeo-postgis >= 2.4.4, opengeo-geoserver >= 2.4.5, opengeo-docs >= 2.4.5
Patch: geoexplorer_webxml.patch

%if 0%{?centos} == 6
%define TOMCAT tomcat6
%else
%define TOMCAT tomcat5 
%endif

# the current patch will fail under newer rpmbuild package which
# uses fuzz 0 - this implies the patch needs rediffing - hack for now
%define _default_patch_fuzz 2
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
   mkdir -p $RPM_BUILD_ROOT/var/lib/%{TOMCAT}/webapps

   cp -rp $RPM_SOURCE_DIR/opengeo-suite/dashboard.war $RPM_BUILD_ROOT/var/lib/%{TOMCAT}/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/geoeditor.war $RPM_BUILD_ROOT/var/lib/%{TOMCAT}/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/geowebcache.war $RPM_BUILD_ROOT/var/lib/%{TOMCAT}/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/recipes.war $RPM_BUILD_ROOT/var/lib/%{TOMCAT}/webapps/.
   cp -rp $RPM_SOURCE_DIR/opengeo-suite/geoexplorer.war $RPM_BUILD_ROOT/var/lib/%{TOMCAT}/webapps/.

%post
   # check for upgrade, if so preserve geoexp web.xml
   WEBAPPS=/var/lib/%{TOMCAT}/webapps
   GXP=$WEBAPPS/geoexplorer
   TMP=/tmp/opengeo-geoexplorer

   if [ -d $GXP ]; then
     # upgrade, perserve the old web.xml
     if [ -e $TMP ]; then
       rm -rf $TMP
     fi
     mkdir $TMP
     cp $GXP/WEB-INF/web.xml $TMP
   fi
  
   # clear out old app dirs
   APPS="dashboard geoeditor geoexplorer geowebcache recipes"
   for APP in $APPS; do
     if [ -d $WEBAPPS/$APP ]; then
        rm -rf $WEBAPPS/$APP
     fi
   done

   # restore old geoexp web.xml
   if [ -e $TMP/web.xml ]; then
     unzip  $GXP.war -d $GXP > /dev/null 2>&1
     cp $TMP/web.xml $GXP/WEB-INF
     rm -rf $TMP
   fi

   # create link to documentation
   DOCS=/usr/share/opengeo-docs
   if [ -e $DOCS ] && [ ! -e $WEBAPPS/opengeo-docs ]; then
     ln -sf $DOCS $WEBAPPS/opengeo-docs
   fi

   chown tomcat /var/lib/%{TOMCAT}/webapps/*.war
   chkconfig %{TOMCAT} on
   service %{TOMCAT} restart

%preun

  # $1 == 1 means upgrade, on upgrade don't remove the webapps
  if [ "$1" == "0" ]; then
    service %{TOMCAT} stop

    WEBAPPS=/var/lib/%{TOMCAT}/webapps
    APPS="dashboard geoeditor geoexplorer geowebcache recipes"
    for APP in $APPS; do
      if [ -e $WEBAPPS/$APP ]; then
         rm -rf $WEBAPPS/$APP $WEBAPPS/$APP.war
      fi
    done

    if [ -L $WEBAPPS/opengeo-docs ]; then
      unlink $WEBAPPS/opengeo-docs
    fi

    service %{TOMCAT} restart
  fi

%postun

%clean

%files
%defattr(-,root,root,-)
/var/lib/%{TOMCAT}/webapps/dashboard.war
/var/lib/%{TOMCAT}/webapps/geoeditor.war
/var/lib/%{TOMCAT}/webapps/geoexplorer.war
/var/lib/%{TOMCAT}/webapps/geowebcache.war
/var/lib/%{TOMCAT}/webapps/recipes.war
