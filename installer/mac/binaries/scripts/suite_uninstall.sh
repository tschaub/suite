#!/bin/bash

echo ""
echo "Removing OpenGeo Suite files..."
echo ""

# Verbose?
if [ "x$1" == "x" ]; then
  echo "Running in verbose mode..."
  rmopts="v"
else
  rmopts=""
fi

# Check for running suite
suite_port=8080
netport=`netstat -f inet -n | cut -c 22-44 | grep -v "\*" | cut -f5 -d. | tr -d ' ' | sort | uniq | grep -x $suite_port`
if [ "x$netport" != "x" ]; then
  echo "Shutting down the Suite..."
  /opt/opengeo/suite/opengeo-suite stop > /dev/null
fi

# Remove GUI Apps
if [ -d /Applications/OpenGeo ]; then
  rm -rf$rmopts /Applications/OpenGeo
fi

# Remove Server Apps
if [ -d /opt/opengeo ]; then
  rm -r$rmopts /opt/opengeo
fi

# Remove Config Files
find /Users -name .opengeo -maxdepth 2 -type d -exec /bin/rm -rvf {} ';'

# Remove Path Entries
if [ -f /private/etc/paths.d/opengeo-pgsql ]; then
  rm -f$rmopts /private/etc/paths.d/opengeo-pgsql
fi
if [ -f /private/etc/manpaths.d/opengeo-pgsql ]; then
  rm -f$rmopts /private/etc/manpaths.d/opengeo-pgsql
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

