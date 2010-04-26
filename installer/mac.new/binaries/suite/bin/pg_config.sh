#
# GLOBALS
#
pg_version=8.4
postgis_version=1.5
pg_default_port=54321

pg_data_dir=/opt/opengeo/pgdata/${USER}
pg_log=/opt/opengeo/pgdata/${USER}_pgsql.log

pg_dir=/opt/opengeo/pgsql/$pg_version
pg_bin_dir=$pg_dir/bin
pg_lib_dir=$pg_dir/lib

#
# FUNCTIONS
#
function pg_check_ini {
  local port
  local ini="$HOME/.opengeo/config.ini"
  # Set defaults
  pg_port=$pg_default_port
  # Read ini
  if [ -f "$ini" ]; then
    port=`grep pgsql_port "$ini" | cut -f2 -d= | tr -d ' '`
    if [ "x$port" != "x" ]; then
      if [ "$port" -gt 1024 ]; then
        pg_port=$port
      fi
    fi
  fi
}

function pg_check_data {
  if [ -d "$pg_data_dir" ]; then
    if [ -f "$pg_data_dir/PG_VERSION" ]; then
      local version=`cat $pg_data_dir/PG_VERSION`
      if [ "$version" = "$pg_version" ]; then
        echo "good"
      else
        echo "wrong_version"
        pg_data_version="$version"
      fi
    else
      echo "no_version"
    fi
  else
    echo "no_directory"
  fi
}

function pg_check_bin {
  local exe
  local r
  for exe in psql createlang createuser createdb pg_config pg_ctl
  do 
    local pgexe="$pg_bin_dir/${exe}"
    if [ ! -x "$pgexe" ]; then
      r="missing_$exe"
      break
    fi
  done

  if [ ! -d "$pg_lib_dir" ]; then
    r="missing_lib"
  else
    export DYLD_LIBRARY_PATH="$pg_lib_dir"
  fi

  if [ ! "$r" ]; then
    echo "good"
  else
    echo $r
  fi
}


