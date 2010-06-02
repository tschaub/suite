#!/bin/bash

# Script directory
d=`dirname $0`

# Load versions
source ${d}/hudson_config.sh

if [ -d ${buildroot}/pgsql ]; then
  rm -rf ${buildroot}/pgsql
fi

exit 0
    
