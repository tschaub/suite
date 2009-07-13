Installing the OpenGeo Suite
============================

This document will discuss how to install the OpenGeo Suite.  More detailed operating instructions are contained inside the archive.


Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

.. list-table::
   :widths: 20 80

   * - **Operating System**
     - Windows XP, Vista, Server 2000, Server 2003, Server 2008 (all 32 bit)
   * - **Memory**   
     - 512MB minimum (1GB recommended)
   * - **Disk space**
     - 150MB minimum (plus extra space for your data)
   * - **Browser**
     - Any modern web browser is supported
   * - **Permissions**
     - Administrative rights


Installation
------------

#. Double click on the :file:`OpenGeoSuite.exe` file.

#. At the **Welcome** screen, click :guilabel:`Next`.

   .. figure:: img/welcome.png
      :align: center

      *The Welcome screen*

#. Read the **License Agreement** then click :guilabel:`I Agree`.

   .. figure:: img/license.png
      :align: center

      *The License Agreement*

#. Type in the **Destination folder** where you would like to install the OpenGeo Suite, and click :guilabel:`Next`.  (This can usually be left as the default.)

   .. figure:: img/directory.png
      :align: center

      *The destination for the installation*

#. Select the name and location of the **Start Menu folder** to be created.  (This can usually be left as the default.)

   .. figure:: img/startmenu.png
      :align: center

      *The Start Menu folder to be created*

#. You can install the OpenGeo Suite in one of two ways.
  
   * :guilabel:`Run manually` - GeoServer is run like a standard application.  This is useful for evaluating the software. 
   * :guilabel:`Install as a service` - This integrates GeoServer with Windows Services.  This is more secure, and is the preferred method of running in a production environment.

   If you are not sure which selection to choose, select :guilabel:`Run manually`.

   .. figure:: img/installtype.png
      :align: center

      *Select Manual or Service installation*

#. Review all the information and click :guilabel:`Back` to make any changes.  Click :guilabel:`Install` to perform the installation.

   .. figure:: img/ready.png
      :align: center

      *Verify all settings before continuing*

#. The OpenGeo Suite requires a **Java Runtime Environment (JRE)**.  If the installer is unable to detect a JRE on your system, it will install its own prior to the installation.

   .. figure:: img/jre.png
      :align: center

      *The installer will install a JRE on your system if necessary*

#. Please wait while the installation proceeds.

   .. figure:: img/install.png
      :align: center

      *Installation*

#. After installation, click :guilabel:`Finish` to run the Data Importer to load shapefiles into GeoServer.  If you would like to run the Data Importer at a later time, uncheck the box and then click :guilabel:`Finish`.

   .. figure:: img/finish.png
      :align: center

      *The OpenGeo Suite successfully installed*


   .. note:: With the exception of the initial running of the Data Importer after installation, GeoServer will always need to be started and stopped manually.  To start or stop GeoServer, please use the shortcuts in the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer` folder.

For more information, please see the document titled **Getting Started**, which is available in the Start Menu at :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Getting Started`.


Upgrading
---------

In order to upgrade to a newer version of the OpenGeo Suite, it is first necessary to uninstall the current version.  A new installer will not install on top of the current installation, and having two parallel installs on the same system is not supported.


Uninstallation
--------------

#. Navigate to :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Uninstall`.

   .. note:: Uninstallation is also available via the standard Windows program removal workflow (i.e. **Add/Remove Programs** for Windows XP, **Installed Programs** for Windows Vista, etc.)

#. Click :guilabel:`Uninstall` to start the uninstallation process.

   .. figure:: img/uninstall.png
      :align: center

      *Ready to uninstall the OpenGeo Suite*

#. The uninstaller will ask if you wish to keep your existing GeoServer data directory.  If you are upgrading, select :guilabel:`Yes`.  If you wish to completely remove the OpenGeo Suite, select :guilabel:`No`.

   .. warning:: Deleting the data directory is *not* undoable!

   .. figure:: img/keepdatadir.png
      :align: center

      *Keep or delete your existing GeoServer data directory*

#. When done, click :guilabel:`Close`.

   .. figure:: img/unfinish.png
      :align: center

      *The OpenGeo Suite is successfully uninstalled*


Credits
-------

All text content created by OpenGeo and licensed under the `Creative Commons Share-Alike license <http://creativecommons.org/licenses/by-sa/3.0>`_.

All code is copyrighted by their respective owners.

For More Information
--------------------

Please visit http://opengeo.org or email inquiry@opengeo.org .