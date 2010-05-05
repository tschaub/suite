set -e

APP=$1
if [ ! -d "$APP" ]; then
    echo "ERROR: could not find app directory: $APP" >&2
    exit 1
fi

# titanium could be local or system install
if [ -d ~/.titanium ]; then
    TITANIUM=~/.titanium
elif [ -d /opt/titanium ]; then
    TITANIUM=/opt/titanium
else
    echo "ERROR: could not find titanium." >&2
    exit 1
fi

# assume OS is first directory in sdk
OS=$(ls -d "$TITANIUM"/sdk/*/ | xargs -l basename | sed 1p -n)

# extract runtime version from manifest
RUNTIME=$(grep -m 1 runtime "$APP"/manifest | sed 's/runtime:\(.*\)/\1/')

if [ ! -d "$TITANIUM/sdk/$OS/$RUNTIME" ]; then
    echo "ERROR: could not find $TITANIUM/sdk/$OS/$RUNTIME." >&2
    exit 1
fi

# run the tibuild.py packager
mkdir .appshell
python "$TITANIUM/sdk/$OS/$RUNTIME"/tibuild.py -a "$TITANIUM"/sdk/ -v -n -d .appshell -t bundle "$APP"

# strip our contents of resources dir, zip up, and clean
ZIP=dashboard-"$RUNTIME-$OS".zip
rm -f "$ZIP"
rm -rf .appshell/"$APP"/Resources/*
zip -r "$ZIP" "$APP"
rm -rf .appshell

echo "Application skeleton archived in $ZIP."
