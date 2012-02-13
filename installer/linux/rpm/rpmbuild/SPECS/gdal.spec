Summary: Geospatial Data Abstraction Library
Name: gdal
Version: 1.8.1
Release: 1%{?dist}
License: MIT/X
Group: Applications/Engineering
URL: http://www.gdal.org/

Source: http://download.osgeo.org/gdal/gdal-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires: gcc
BuildRequires: geos-devel >= 3.0.0

Requires: geos >= 3.0.0
Requires: swig

Patch: gdal_driverpath.patch

%description
The Geospatial Data Abstraction Library (GDAL) is a unifying C/C++ API for 
accessing raster geospatial data, and currently includes formats like 
GeoTIFF, Erdas Imagine, Arc/Info Binary, CEOS, DTED, GXF, and SDTS. It is 
intended to provide efficient access, suitable for use in viewer 
applications, and also attempts to preserve coordinate systems and 
metadata. Perl, C, and C++ interfaces are available.

# gdal-devel
%package devel
Summary: Header files, libraries and development documentation for %{name}.
Group: Development/Libraries
Requires: %{name} = %{version}-%{release}

%description devel
This package contains the header files, static libraries and development
documentation for %{name}. If you like to develop programs using %{name},
you will need to install %{name}-devel.

%files devel
%defattr(-, root, root, 0755)
%{_includedir}/*.h

%package mrsid
Summary: MrSID Plugin for the Geospatial Data Abstraction Library
Group: Applications/Engineering
Requires: %{name} = %{version}-%{release}

%description mrsid
This package contains a plugin that enables %{name} to read MrSID files. This includes
a copy of the Lizard Tech raster DSDK libraries.

%files mrsid
%defattr(-, root, root, 0755)
%{_libdir}/gdalplugins/gdal_MrSID.so
%{_libdir}/libltidsdk.so*

%prep
%setup
%ifarch x86_64
# In RedHat land, 32-bit libs go in /usr/lib and 64-bit ones go in /usr/lib64.
# The default driver search paths need changing to reflect this.
%patch
%endif

%build
%configure --datadir=/usr/share/gdal --disable-static
make %{?_smp_mflags}

# MrSID Plugin
g++ -g frmts/mrsid/*.cpp -shared -o gdal_MrSID.so \
-DOGR_ENABLED -D_REENTRANT -DMRSID_J2K -fPIC -DPIC \
-Ifrmts/gtiff/libgeotiff/ -Igcore -Iogr -Iport -I$MRSID_ROOT/include \
-L$MRSID_ROOT/lib -L.libs \
-lgdal -lltidsdk -lpthread -ldl

# Java SWIG bindings
cd swig/java
make %{?_smp_mflags}

%install
rm -rf %{buildroot}
make install DESTDIR=%{buildroot}

%ifarch x86_64 # 32-bit libs go in /usr/lib while 64-bit libs go in /usr/lib64
%define lib_dir /usr/lib64
%else
%define lib_dir /usr/lib
%endif
mkdir -p %{buildroot}/%{lib_dir}/gdalplugins
cp gdal_MrSID.so %{buildroot}/%{lib_dir}/gdalplugins/
cp $MRSID_ROOT/lib/libltidsdk.so* %{buildroot}/%{lib_dir}
cp swig/java/*.so %{buildroot}/%{lib_dir}

%clean
rm -rf %{buildroot}

%post -p /sbin/ldconfig
%postun -p /sbin/ldconfig

%files
%defattr(-, root, root, 0755)
%{_bindir}/*
%{_datadir}/gdal/
%{_libdir}/lib*
