OpenGeo Suite Mac Installer Instructions
========================================

This document contains instructions that describe how to build the OpenGeo suite installer for the mac.


Build the Suite Distribution
----------------------------

From the root of the suite source tree build a distribution with the commands:

  mvn clean install -Dfull
  mvn assembly:attached

Upon success the artifact 'target/suite-<VERSION>-raw.zip' will be created.


Build the Dashboard
-------------------

Change directory to the 'dashboard' module directly under the root of the suite source tree.

Ensure the 'tibuild.py' script is on your PATH. It is located under:

  /Library/Application Support/Titanium/sdk/osx/<VERSION>

Build the dashboard app by executing the following command:

  tibuild.py -d . -s /Library/Application\ Support/Titanium -a /Library/Application\ Support/Titanium/sdk/osx/0.7.0/ OpenGeo\ Dashboard/

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

Click the "Build" button in the menu and save the result as "Dashboard.pkg" in the "pkg" directory.


Build the Suite Services Package
--------------------------------

Unzip the "suite-<VERISON>-mac.zip" artifact created in the first section into the "app/OpenGeo Suite.app/Contents/Resources/Java" directory:

  unzip ../../target/suite-<VERSION>-mac.zip -d app/OpenGeo\ Suite.app/Contents/Resources/Java

Open the "services.pmdoc" PackageMaker project:

  open suite.pmdoc

Click the "Build" button in the menu and save the result as "Services.pkg" in the "pkg" directory.


Build the Suite Package
-----------------------

Unzip the "suite-<VERSION>-doc.zip" and "suite-<VERSION>-ext.zip" artifacts created in the first section into the "pkg" directory:

  unzip ../../target/suite-<VERSION>-doc.zip -d pkg
  unzip ../../target/suite-<VERSION>-ext.zip -d pkg













