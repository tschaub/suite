#!/bin/bash

# Remove GUI Apps
if [ -d /Applications/OpenGeo ]; then
  rm -rf /Applications/OpenGeo
fi

# Remove Server Apps
if [ -d /opt/opengeo ]; then
  rm -rf /opt/opengeo
fi

# Remove Config Files
find /Users -name .opengeo -maxdepth 2 -type d -exec /bin/rm -rf {} ';'

# Remove Path Entries
if [ -f /private/etc/paths.d/opengeo-pgsql ]; then
  rm /private/etc/paths.d/opengeo-pgsql
fi
if [ -f /private/etc/manpaths.d/opengeo-pgsql ]; then
  rm /private/etc/manpaths.d/opengeo-pgsql
fi

# Remove receipts entries
find /Library/Receipts -name "org.opengeo.*" -exec /bin/rm -rf {} ';'
find /var/db/receipts -name "org.opengeo.*" -exec /bin/rm -rf {} ';'

