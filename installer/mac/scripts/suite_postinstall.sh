#!/bin/sh

DEST=$2
if [ -e "$DEST/OpenGeoSuite.app" ]; then
  F="$DEST/OpenGeoSuite.app/Contents/Resources/uninstaller.sh"
  touch  "$F"

  echo '#!/bin/bash' >> "$F"
  echo "" >> "$F"
  echo 'if [ "`whoami`" != "root" ]; then' >> "$F"
  echo '  echo "This script must be run as root"' >> "$F"
  echo '  exit 1' >> "$F" 
  echo 'fi' >> "$F"
  echo "" >> "$F"
  echo 'pushd `dirname $0` > /dev/null' >> "$F"
  echo "" >> "$F"
  echo "" >> "$F"
  echo 'echo "This script will remove the following directories:"' >> "$F"
  echo 'echo ""' >> "$F"
  echo "" >> "$F"
  echo 'for script in `ls *-manifest.sh`; do' >> "$F"
  echo '   ./$script' >> "$F"
  echo 'done' >> "$F"
  echo "" >> "$F"
  echo 'echo ""' >> "$F"
  echo 'echo -n "Would you like to continue? [Y|n]:" ' >> "$F"
  echo 'read CONTINUE' >> "$F"
  echo 'CONTINUE=`echo $CONTINUE | tr -s " "`' >> "$F"
  echo 'CONTINUE=`echo $CONTINUE | tr -s [:upper:] [:lower:]`' >> "$F"
  echo 'if [ "$CONTINUE" != "yes" ] && [ "$CONTINUE" != "y" ]; then' >> "$F"
  echo '   echo "Exiting"' >> "$F"
  echo '   exit 0' >> "$F"
  echo 'fi' >> "$F"
  echo 'for script in `ls *-uninstall.sh`; do' >> "$F"
  echo '   ./$script' >> "$F"
  echo 'done' >> "$F"
  echo "rm -rf \"$DEST/OpenGeoSuite.app\"" >> "$F"
  echo "" >> "$F"
  echo 'rm -rf /Library/Receipts/OpenGeo_Services.pkg' >> "$F"
  echo "" >> "$F"
  echo 'popd > /dev/null' >> "$F"
  echo 'exit 0' >> "$F" 
  
  chmod +x "$F" 

  F="$DEST/OpenGeoSuite.app/Contents/Resources/suite-manifest.sh"
  touch  "$F"
  echo '#!/bin/bash' >> "$F"
  echo "" >> "$F"
  echo "echo \"$DEST/OpenGeoSuite.app\"" >> "$F"
  echo "echo \"/Library/Receipts/OpenGeo_Services.pkg\"" >> "$F"
  echo "exit 0" >> "$F"

  chmod +x "$F"
fi

exit 0
