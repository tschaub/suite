#!/bin/bash

postgres_user=_opengeo
postgres_group=_opengeo

launchctl stop org.opengeo.postgis
launchctl unload /Library/LaunchDaemons/
rm /Library/LaunchDaemons/org.opengeo.postgis
launchctl load /Library/LaunchDaemons/
kill `cat /opt/opengeo/pgsql/8.4/data/postmaster.pid | head -n1` >> /dev/null
rm -rf /Applications/OpenGeo
rm /etc/paths.d/opengeo-pgsql
rm /etc/manpaths.d/opengeo-pgsql
rm -rf /opt/opengeo
dscl . -delete /Groups/$postgres_group
dscl . -delete /Users/$postgres_user
