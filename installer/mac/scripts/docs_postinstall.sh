#!/bin/bash

DEST="$2/../../../../Resources"
if [ -e "$DEST" ]; then
  F="$DEST/docs-uninstall.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo >> "$F"
  echo "rm -rf /Library/Receipts/opengeodocs.pkg" >> "$F"
  echo "exit 0" >> "$F"

  chmod +x "$F"

  F="$DEST/docs-manifest.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo "echo \"/Library/Reciepts/opengeodocs.pkg\"" >> "$F"
  echo "exit 0" >> "$F"
  
  chmod +x "$F"
fi

exit 0
