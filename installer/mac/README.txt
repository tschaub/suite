OpenGeo Suite Mac Installer Instructions
========================================

This document contains instructions that describe how to build the OpenGeo suite installer for the mac.


Build the Suite Distribution
----------------------------

From the root of the suite source tree build a distribution with the commands:

  mvn clean install -Dfull
  mvn assembly:attached

Upon success the artifact 'target/suite-<VERSION>-mac.zip' will be created.


Get the Titanium SDK
--------------------

http://www.appcelerator.com/products/download/


Build the Dashboard
-------------------

Change directory to the 'dashboard' module directly under the root of the suite source tree.

Ensure the 'tibuild.py' script is on your PATH. It is located under:

  /Library/Application Support/Titanium/sdk/osx/<VERSION>

Build the dashboard app by executing the following command:

  tibuild.py -d . -s /Library/Application\ Support/Titanium -a /Library/Application\ Support/Titanium/sdk/osx/0.8.0/ OpenGeo\ Dashboard/

*Note*: If the command errors out with a message about "OpenGeo Dashboard.dmg" that is OK.

Upon success the directory "OpenGeo Dashboard.app" will be created. To test that the artifact was built properly execute the command:

  open OpenGeo\ Dashboard.app

This should run the dashboard.


Build the Dashboard Package
---------------------------

Change directory to 'installer/mac' under the root of the suite source tree.

Move the "OpenGeo Dashboard.app" directory from the previous section into the 'app' directory:

   mv ../../dashboard/OpenGeo\ Dashboard.app app

Open the "dashboard.pmdoc" PackageMaker project:

   open dashboard.pmdoc

Click the "Build" button in the menu and save the result as "OpenGeo_Dashboard.pkg" in the "pkg" directory.


Build the Suite Services Package
--------------------------------

Unzip the "opengeosuite-<VERSION>-mac.zip" artifact created in the first section into the "app/OpenGeo Suite.app/Contents/Resources/Java" directory:

  unzip ../../target/opengeosuite-<VERSION>-mac.zip -d app/OpenGeo\ Suite.app/Contents/Resources/Java

Open the "services.pmdoc" PackageMaker project:

  open services.pmdoc

Click the "Build" button in the menu and save the result as "OpenGeo_Services.pkg" in the "pkg" directory.

Build the PostGIS Package
-------------------------

Unzip the opengeosuite-<VERSION>-mac-postgis.zip artifact created in the first section into the "app/OpenGeo PostGIS" directory.

  unzip ../../target/opengeosuite-<VERSION>-mac-postgis.zip -d app/OpenGeo\ PostGIS/
  mv app/OpenGeo\ PostGIS/pgsql/pgShapeLoader.app/ app/OpenGeo\ PostGIS/
  mv app/OpenGeo\ PostGIS/pgsql/pgAdmin3.app/ app/OpenGeo\ PostGIS/
  sudo chown -R root:admin app/OpenGeo\ PostGIS/

Open the "postgis.pmdoc" PackageMaker project:

  open postgis.pmdoc


Build the Suite Package
-----------------------

Unzip the "suite-<VERSION>-doc.zip" and "suite-<VERSION>-ext.zip" artifacts created in the first section into the "pkg" directory:

  unzip ../../target/opengeosuite-<VERSION>-ext.zip -d pkg

Open the "suite.pmdoc" PackageMaker project:

  open suite.pmdoc

Click the "Build" button in the menu and save the result as "OpenGeoSuite.mpkg"
