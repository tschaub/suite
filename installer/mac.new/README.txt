#!/bin/bash

# Useful Apple Packaging References
# ========================================
#
# Guidelines for Developers
# http://developer.apple.com/tools/installerpolicy.html
#
# Packagemaker Howto
# http://s.sudre.free.fr/Stuff/PackageMaker_Howto.html
#
# Packagemaker Man Page
# http://developer.apple.com/mac/library/documentation/Darwin/Reference/ManPages/man1/packagemaker.1.html
#
# Software Delivery Guide
# http://developer.apple.com/mac/library/documentation/DeveloperTools/Conceptual/SoftwareDistribution/Introduction/Introduction.html

#
# Receipts
# ========
#
# The presence or absense of a receipt determines whether the Apple 
# Installer runs in install or upgrade mode. In Leopard and earlier,
# receipts were in /Library/Receipts. In Snow Leopard and up, they
# are in /var/db/receipts
#

#
# OpenGeo Suite Mac Requirements
# ========================================

# Get the Titanium SDK
# --------------------
#
# http://www.appcelerator.com/products/download/
#
# Get the Iceberg package maker
# -----------------------------
#
# http://s.sudre.free.fr/Software/Iceberg.html
#

# OpenGeo Suite Mac Layout
# ========================
# 
# The Mac install is made up of multiple pkg installers that are bundled into
# a single mpkg for installation. Note that both server components include a 
# VERSION file, so that components can be kept in synch in the future (avoid
# installing a new version of one component next to old version of another).
#
# PostGIS Server.pkg
#  /opt/opengeo/pgsql/*
#  /opt/opengeo/suite/VERSION
#  /Library/LaunchDaemons/org.opengeo.postgis
#  Preinstall scripts to alter shmmem and create
#    /etc/paths.d/opengeo-postgis
#    /etc/manpaths.d/opengeo-postgis
#
# GeoServer.pkg
#  /opt/opengeo/geoserver/*
#  /opt/opengeo/suite/VERSION
#  /Library/LaunchDaemons/org.opengeo.geoserver
#  Preinstall scripts to find existing data_dir and preserve it
#  Preinstall scripts to wipe out existing OpenGeo Suite.app
#  Postinstall scripts to bring in any existing data_dir
#
# PostGIS Client.pkg
#  /Applications/OpenGeo/pgShapeLoader.app
#  /Applications/OpenGeo/pgAdmin III.app
#
# DashBoard.pkg
#  Preinstall scripts to wipe out any existing OpenGeo Dashboard.app
#  /Applications/OpenGeo/OpenGeo Dashboard.app
#
# OpenGeo Suite.mpkg
#  Master package container.
#

# OpenGeo Suite Mac Build
# =======================

# Build the Suite Distribution
# ----------------------------
#
#  From the root of the suite source tree build a distribution with the commands:
#
  cd ../..
  mvn clean install -Dfull
  mvn assembly:attached
  cd installer/mac.new
#
# Upon success the artifact 'target/suite-<VERSION>-mac.zip' will be created.
#

# Build the Dashboard
# -------------------
#
# Change directory to the 'dashboard' module directly under the root 
# of the suite source tree.
#
  cd ../../dashboard
#
# Ensure the 'tibuild.py' script is on your PATH. It is located under:
#  
dashboard=0
if [ $dashboard ]; then

  titanium_version=1.0.0
  export PATH=$PATH:/Library/Application\ Support/Titanium/sdk/osx/$titanium_version
#
# Build the dashboard app by executing the following command:
#
  tibuild.py -d . \
             -s /Library/Application\ Support/Titanium \
             -a /Library/Application\ Support/Titanium/sdk/osx/0.8.0/ \
             OpenGeo\ Dashboard/
fi

#
# Note: If the command errors out with a message about 
# "OpenGeo Dashboard.dmg" that is OK.
#
# Upon success the directory "OpenGeo Dashboard.app" will be created. 
# To test that the artifact was built properly execute the command:
#
#  open OpenGeo\ Dashboard.app
#
# This should run the dashboard.
#
#
# Build the Dashboard Package
# ---------------------------
#
#
# Move the "OpenGeo Dashboard.app" directory from the previous section 
# into the 'binaries' directory:
#
  cd ../installer/mac.new
if [ $dashboard ]; then
  rm -rf "binaries/OpenGeo Dashboard.app"
  cp -r "../../dashboard/OpenGeo Dashboard.app" "binaries/OpenGeo Dashboard.app"
fi
#
# Build the dashboard using the Iceberg 'freeze' commandline
#
   rm -rf "./build/Dashboard.pkg/"
   freeze ./dashboard.packproj
#
# The Dashboard.pkg will be built into the ./build/ subdirectory
#

# Build the Geoserver Package
# --------------------------------
#
# Unzip the "opengeosuite-<VERSION>-mac.zip" artifact created in the 
# first section into the "app/OpenGeo Suite.app/Contents/Resources/Java" 
# directory:
#
  suite_version=1.0
  rm -rf binaries/geoserver
  unzip ../../target/opengeosuite-$suite_version-mac.zip \
        -d binaries/geoserver
  chmod 755 binaries/geoserver/opengeo-suite
  find binaries/geoserver/data_dir -type d -exec chmod 775 {} ';'
  find binaries/geoserver/data_dir -type f -exec chmod 664 {} ';'
#
# Build the geoserver pkg using the Iceberg 'freeze' commandline
#
  rm -rf ./build/GeoServer.pkg
  freeze ./geoserver.packproj
#
# The GeoServer.pkg will be built into the ./build/ subdirectory
#

# Build the PostGIS Package
# -------------------------
#
# Unzip the postgres-osx.zip artifact downloaded from data.opengeo.org 
# into the binaries directory.
#
  rm -rf binaries/pgsql
  unzip ../../assembly/postgres-osx.zip \
        -d binaries/
#
# Move the apps down one directory level
#
  mv binaries/pgsql/pgShapeLoader.app/ binaries/
  mv binaries/pgsql/pgAdmin3.app/ binaries/
  mv binaries/pgsql/stackbuilder.app/ binaries/
  chmod 755 binaries/pgAdmin3.app/Contents/MacOS/pgAdmin3
  chmod 755 binaries/pgShapeLoader.app/Contents/MacOS/pgShapeLoader*
#
# Give all the files root ownership
# sudo chown -R root:admin "app/OpenGeo PostGIS/"
#
# Build the postgis project using the Iceberg 'freeze' commandline
#
  rm -rf "./build/PostGIS Client.pkg/"
  freeze ./postgisclient.packproj

  rm -rf "./build/PostGIS Server.pkg/"
  freeze ./postgisserver.packproj
#
# The PostGIS.pkg will be built into the ./build/ subdirectory
#

# Build the Suite Scripts Package
# -------------------------------
#
  find ./binaries -name "*.sh" -exec chmod 755 {} ';'
  freeze ./suitescripts.packproj

# Build the GeoServer Extensions Package
# --------------------------------------
#
# Unzip the "suite-<VERSION>-ext.zip" 
# artifact created in the first section into the "binaries" directory:

  suite_version=1.0
  rm -rf ./binaries/ext
  unzip ../../target/opengeosuite-$suite_version-ext.zip -d binaries
  rm -rf "./build/GeoServer Extensions.pkg"
  freeze ./geoserverext.packproj
# 
# Build the Suite Package
# -----------------------
#
  rm -rf ./suitebuild/*
  freeze ./suite.packproj

# The "OpenGeo Suite.mpkg" will be built into the ./suitebuild directory
#
