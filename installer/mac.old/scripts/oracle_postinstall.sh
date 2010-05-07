#!/bin/bash

DEST="$2/../../../../../../Resources"
if [ -e "$DEST" ]; then
  F="$DEST/oracle-uninstall.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo >> "$F"
  echo "rm -rf /Library/Receipts/opengeooracle.pkg" >> "$F"
  echo "exit 0" >> "$F"

  chmod +x "$F"

  F="$DEST/oracle-manifest.sh"
  touch "$F"
  echo '#!/bin/bash' >> "$F"
  echo "echo \"/Library/Receipts/opengeooracle.pkg\"" >> "$F"
  echo "exit 0" >> "$F"

  chmod +x "$F"
fi

exit 0
