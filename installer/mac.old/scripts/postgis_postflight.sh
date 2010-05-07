#!/bin/bash

# Update the shared memory values to support PostgreSQL!

# Desired values
pg_shmall=65536    # 64kb
pg_shmmax=67108864 # 64Mb

# Current values
shmall=`sysctl -n kern.sysv.shmall`
shmmax=`sysctl -n kern.sysv.shmmax`

function dosysctl {
  if [ "$2" -lt "$3" ]
  then
    if [ -f /etc/sysctl.conf ]
    then
      cat /etc/sysctl.conf | grep -v $1 > /tmp/sysctl
      mv -f /tmp/sysctl /etc/sysctl.conf
    fi
    echo "$1=$3" >> /etc/sysctl.conf
    /usr/sbin/sysctl -w $1=$3 > /dev/null
  fi
}

dosysctl kern.sysv.shmall $shmall $pg_shmall
dosysctl kern.sysv.shmmax $shmmax $pg_shmmax

