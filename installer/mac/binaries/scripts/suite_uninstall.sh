#!/bin/bash

echo ""
echo "Removing OpenGeo Suite files..."
echo ""

# Remove GUI Apps
if [ -d /Applications/OpenGeo ]; then
  rm -rvf /Applications/OpenGeo
fi

# Remove Server Apps
if [ -d /opt/opengeo ]; then
  rm -rvf /opt/opengeo
fi

# Remove Config Files
find /Users -name .opengeo -maxdepth 2 -type d -exec /bin/rm -rvf {} ';'

# Remove Path Entries
if [ -f /private/etc/paths.d/opengeo-pgsql ]; then
  rm -vf /private/etc/paths.d/opengeo-pgsql
fi
if [ -f /private/etc/manpaths.d/opengeo-pgsql ]; then
  rm -vf /private/etc/manpaths.d/opengeo-pgsql
fi

# Remove receipts entries
if [ -d /Library/Receipts ]; then
  find /Library/Receipts -name "org.opengeo.*" -exec /bin/rm -rvf {} ';'
fi
if [ -d /var/db/receipts ]; then
  find /var/db/receipts -name "org.opengeo.*" -exec /bin/rm -rvf {} ';'
fi

echo ""
echo "The OpenGeo Suite is now uninstalled."
echo ""

