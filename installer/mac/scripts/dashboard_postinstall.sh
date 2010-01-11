#!/bin/sh

DEST=$2
if [ -e "$DEST/OpenGeo Dashboard.app" ]; then
  sed -i .bak 's/@SUITE_EXE@/\/Applications\/OpenGeo Suite.app/g' "$DEST/OpenGeo Dashboard.app/Contents/Resources/config.ini"

  sed -i .bak 's/@SUITE_DIR@/\/Applications\/OpenGeo Suite.app\/Contents\/Resources\/Java/g' "$DEST/OpenGeo Dashboard.app/Contents/Resources/config.ini"
fi
exit 0
