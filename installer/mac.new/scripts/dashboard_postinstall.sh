#!/bin/sh

DEST=$2
if [ -e "$DEST/OpenGeo Dashboard.app" ]; then
  sed -i .bak 's/@SUITE_EXE@/\/Applications\/OpenGeo Suite.app\/Contents\/Resources\/Java\/opengeo-suite/g' "$DEST/OpenGeo Dashboard.app/Contents/Resources/config.ini"

  sed -i .bak 's/@SUITE_DIR@/\/Applications\/OpenGeo Suite.app\/Contents\/Resources\/Java/g' "$DEST/OpenGeo Dashboard.app/Contents/Resources/config.ini"

  sed -i .bak 's/@GEOSERVER_DATA_DIR@/\/Applications\/OpenGeo Suite.app\/Contents\/Resources\/Java\/data_dir/g' "$DEST/OpenGeo Dashboard.app/Contents/Resources/config.ini"

  F="$2/OpenGeo Suite.app/Contents/Resources/dashboard-uninstall.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo "" >> "$F" 
  echo "rm -rf \"$DEST/OpenGeo Dashboard.app\"" >> "$F" 
  echo "rm -rf \"/Library/Receipts/OpenGeo_Dashboard.pkg\"" >> "$F" 
  echo "exit 0" >> "$F"

  chmod +x "$F"

  F="$2/OpenGeo Suite.app/Contents/Resources/dashboard-manifest.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo "" >> "$F" 
  echo "echo \"$DEST/OpenGeo Dashboard.app\"" >> "$F" 
  echo "echo \"/Library/Receipts/OpenGeo_Dashboard.pkg\"" >> "$F" 
  echo "exit 0" >> "$F"

  chmod +x "$F"

fi

exit 0
