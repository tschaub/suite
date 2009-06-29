Installing the OpenGeo Suite
============================

Instructions on how to install the OpenGeo Suite.

Prerequisites
-------------

The OpenGeo Suite requires the following system:

* Operating System - Windows XP, Vista, Server 2000, Server 2003, Server 2008
   * 32 bit systems only
* Memory - 512MB minimum (1GB recommended)
* Disk space - 60MB minimum (plus extra space for your data)
* Modern web browser

In addition, administrative rights will be required to install on your system.

Installation
------------

#. Double click on the :file:`OpenGeoSuite.exe` file.

#. At the **Welcome** screen, click :guilabel:`Next`.

   .. todo:: Screenshot: welcome

#. Read the License Agreement then click :guilabel:`I Agree`.

   .. todo:: Screenshot: License

#. Type in the **Destination Folder** where you would like to install the OpenGeo Suite, and click :guilabel:`Next`.  (Usually, this can be left as the default.)

   .. todo:: Screenshot: Prog location

#. Select the name and location of the Start Menu folder to be created.  (Usually, this can be left as the default.)

   .. todo:: Screenshot: SM location

#. Review all the information and click :guilabel:`Back` to make any changes.  Click :guilabel:`Next` to perform the installation.

   .. note:: The OpenGeo Suite requires a Java Runtime Environment (JRE).  If Setup does not detect that a JRE has been installed, Setup will install a bundled JRE prior to continuing with the installation.

   .. todo:: Screenshot: Ready
 
#. After installation, the Finish scren will be displayed.  Click :guilabel:`Finish` to open the OpenGeo Data Importer to load shapefiles into GeoServer, or uncheck the box and then click :guilabel:`Finish` if you would like to run the OpenGeo Data Importer at a later time.

   .. note:: GeoServer is turned on as part of the install, but is not set up to turn on as part of the Windows boot proceScreenshot:.  To start GeoServer after a reboot, please use the :file:`Start GeoServer` shortcut in the Start Menu.

Upgrading
---------

#. Download the latest version from SOMEWHERE, and double click to install.  The installer will detect the existence of prior versions on your system and perform the upgrade automatically.

   .. todo:: SOMEWHERE

   .. todo:: Screenshot: Upgrade

Uninstallation
--------------

#. Navigate to :menuselection:`Start --> Programs --> OpenGeo Suite --> Uninstall`.

   .. note:: Uninstall is also available via the standard Windows program removal workflow (i.e. **Add/Remove Programs** for Windows XP; **Installed Programs** for Windows Vista, etc.)

#. Click :guilabel:`Next` to start the uninstallation process.

   .. todo:: What about the data dir?

#. When done, click :guilabel:`Finish`.


