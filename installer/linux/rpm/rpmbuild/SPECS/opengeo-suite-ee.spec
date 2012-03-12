Name: opengeo-suite-ee
Version: 2.4.5
Release: 1
Summary: OpenGeo Suite Enterprise Edition.
Group: Applications/Engineering
License: see http://geoserver.org
Requires(post): bash
Requires(preun): bash
Requires: opengeo-suite >= 2.4.5

%if 0%{?centos} == 6
%define TOMCAT tomcat6
%else
%define TOMCAT tomcat5 
%endif

%define _rpmdir ../
%define _rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm
%define _unpackaged_files_terminate_build 0

%description
The OpenGeo Suite Enterprise Edition provides additional modules and extensions
 geared toward enterprise and production systems.  

%prep

%install
   rm -rf $RPM_BUILD_ROOT

   LIB=$RPM_BUILD_ROOT/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib
   mkdir -p $LIB
   cp -rp  $RPM_SOURCE_DIR/opengeo-suite-ee/*.jar  $LIB

%post
  service %{TOMCAT} restart

%preun

%postun
  service %{TOMCAT} restart

%clean

%files
%defattr(-,root,root,-)
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/analytics-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/control-flow-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/monitoring-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/antlr-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/asm-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/asm-attrs-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/cglib-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/cglib-nodep-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/dom4j-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/ehcache-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/ejb3-persistence-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/geoip-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/hibernate-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/hibernate-annotations-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/hibernate-commons-annotations-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/hibernate-entitymanager-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/jcommon-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/jfreechart-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/joda-time-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/jta-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/persistence-api-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/poi-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/spring-orm-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/wicket-datetime-*.jar
/var/lib/%{TOMCAT}/webapps/geoserver/WEB-INF/lib/
