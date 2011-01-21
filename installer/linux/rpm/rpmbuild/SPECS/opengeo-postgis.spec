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
%post
        su - postgres -c "createdb template_postgis"
        su - postgres -c "createlang plpgsql template_postgis"
        su - postgres -c "psql -d template_postgis -f /usr/share/postgresql/8.4/contrib/postgis-1.5/postgis.sql" > /dev/null
        su - postgres -c "psql -d template_postgis -f /usr/share/postgresql/8.4/contrib/postgis-1.5/spatial_ref_sys.sql" > /dev/null
        su - postgres -c "psql -d template_postgis -c \"update pg_database set datistemplate = true where datname = 'template_postgis'\""

        # Adds PgAdmin utilities to the 'postgres' database
        su - postgres -c "psql -f /usr/share/postgresql/8.4/contrib/adminpack.sql -d postgres" > /dev/null

        # Create an 'opengeo' user
        su - postgres -c "createuser --createdb --superuser opengeo"

        # Set the user password?
        su - postgres -c "psql -d postgres -c \"alter user opengeo password 'opengeo'\""

        # create demo database
        su - postgres -c "createdb --owner=opengeo --template=template_postgis medford"

        # Add the data
        su - postgres -c "psql -f /usr/share/opengeo-postgis/medford_taxlots_schema.sql -d medford" > /dev/null
        su - postgres -c "psql -f /usr/share/opengeo-postgis/medford_taxlots.sql -d medford" > /dev/null
        cp /etc/postgresql/8.4/main/pg_hba.conf /etc/postgresql/8.4/main/pg_hba.conf.orig
        if [ ! `cat /etc/postgresql/8.4/main/pg_hba.conf | grep opengeo | wc -l` ]; then
                echo "local     all    opengeo               md5" >> /etc/postgresql/8.4/main/pg_hba.conf
        fi

%preun

%postun

        # turn off error trapping, one of these may fail
        set +e
        su - postgres -c "psql -d template_postgis -c \"update pg_database set datistemplate = false where datname = 'template_postgis'\""
        su - postgres -c "dropdb medford"
        su - postgres -c "dropdb template_postgis"
        su - postgres -c "dropuser opengeo"
        su - postgres -c "psql -f /usr/share/postgresql/8.4/contrib/uninstall_adminpack.sql -d postgres"

        set -e
        # turn it back on

# remove files
# remove users


%clean

%files
%defattr(-,root,root,-)
%dir "/usr/share/opengeo-postgis/*"

