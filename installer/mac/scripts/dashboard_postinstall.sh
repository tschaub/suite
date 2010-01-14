#!/bin/sh

DEST=$2
if [ -e "$DEST/OpenGeoDashboard.app" ]; then
  sed -i .bak 's/@SUITE_EXE@/\/Applications\/OpenGeoSuite.app/g' "$DEST/OpenGeoDashboard.app/Contents/Resources/config.ini"

  sed -i .bak 's/@SUITE_DIR@/\/Applications\/OpenGeoSuite.app\/Contents\/Resources\/Java/g' "$DEST/OpenGeoDashboard.app/Contents/Resources/config.ini"

  F="$2/OpenGeoSuite.app/Contents/Resources/dashboard-uninstall.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo "" >> "$F" 
  echo "rm -rf \"$DEST/OpenGeoDashboard.app\"" >> "$F" 
  echo "rm -rf \"/Library/Receipts/OpenGeo_Dashboard.pkg\"" >> "$F" 
  echo "exit 0" >> "$F"

  chmod +x "$F"

  F="$2/OpenGeoSuite.app/Contents/Resources/dashboard-manifest.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo "" >> "$F" 
  echo "echo \"$DEST/OpenGeoDashboard.app\"" >> "$F" 
  echo "echo \"/Library/Receipts/OpenGeo_Dashboard.pkg\"" >> "$F" 
  echo "exit 0" >> "$F"

  chmod +x "$F"

fi

exit 0
