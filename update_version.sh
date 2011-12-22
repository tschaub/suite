#!/bin/bash

if [ "$#" -lt 2 ]
then
    echo './update_version FROM TO'
    exit
fi

FROM="<version>$1<"
TO="<version>$2<"

find . -name externals -prune -o -name pom.xml -exec sed -i "" "s/$FROM/$TO/g" {} \;

# we do geoserver/externals separately, since we pruned it out above
sed -i "" "s/$FROM/$TO/g" geoserver/externals/pom.xml

echo "Updated version strings in pom.xml files from $1 to $2."
