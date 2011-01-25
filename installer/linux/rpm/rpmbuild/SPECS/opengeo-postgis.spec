Name: opengeo-postgis
Version: 2.3.0
Release: opengeo
Summary: Allows the creation, sharing, and collaborative use of geospatial data.
Group: Applications/Database
License: see http://opengeo.org
Requires(post): bash
Requires(preun): bash
Requires: postgresql84, postgresql84-contrib postgis

%define _rpmdir ../
%define _rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm
%define _unpackaged_files_terminate_build 0

%description
Postgis integration for Opengeo


%install
  rm -rf $RPM_BUILD_ROOT
  mkdir -p $RPM_BUILD_ROOT/usr/share/opengeo-postgis
  cp -rp  $RPM_SOURCE_DIR/opengeo-postgis/*.sql $RPM_BUILD_ROOT/usr/share/opengeo-postgis/.
  cp -rp $RPM_SOURCE_DIR/scripts/postgis-setup.sh $RPM_BUILD_ROOT/usr/share/opengeo-postgis/.
  cp -rp $RPM_SOURCE_DIR/scripts/postgis-uninstall.sh $RPM_BUILD_ROOT/usr/share/opengeo-postgis/.

%post
  sh /usr/share/opengeo-postgis/postgis-setup.sh
  
%preun
  sh /usr/share/opengeo-postgis/postgis-uninstall.sh

%postun

# remove files
# remove users


%clean

%files
%defattr(-,root,root,-)
%dir "/usr/share/opengeo-postgis/*"

