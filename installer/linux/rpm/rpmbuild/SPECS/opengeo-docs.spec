Name: opengeo-docs
Version: 2.3.0
Release: opengeo
Summary: Allows the creation, sharing, and collaborative use of geospatial data.
Group: Documentation
License: see http://opengeo.org
Requires(post): bash
Requires(preun): bash

%define _rpmdir ../ 
%define _rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm 
%define _unpackaged_files_terminate_build 0

%description
Documentation for OpenGeo Suite

%install
  rm -rf $RPM_BUILD_ROOT
  mkdir -p $RPM_BUILD_ROOT/usr/share/opengeo-docs/
  cp -rp  $RPM_SOURCE_DIR/opengeo-docs/docs/* $RPM_BUILD_ROOT/usr/share/opengeo-docs/.
%post

%preun

%postun
# remove files
# remove users


%clean

%files
%defattr(-,root,root,-)
/usr/share/opengeo-docs
