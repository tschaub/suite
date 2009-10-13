Installing the OpenGeo Suite
============================

This document will discuss how to install the OpenGeo Suite.  More detailed operating instructions are available once the software is installed.


Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* **Operating System**: Windows XP, Vista, 7, Server 2000, Server 2003, Server 2008 (all 32 bit)
* **Memory**: 512MB minimum (1GB recommended)
* **Disk space**: 450MB minimum (plus optional extra space for loaded data)
* **Browser**: Any modern web browser is supported (Internet Explorer 7+, Firefox 2+, Chrome 1+)
* **Permissions**: Administrative rights



Installation
------------

#. Double click on the :file:`OpenGeoSuite.exe` file.

#. At the **Welcome** screen, click :guilabel:`Next`.

   .. figure:: img/welcome.png
      :align: center

      *Welcome screen*

#. Read the **License Agreement** then click :guilabel:`I Agree`.

   .. figure:: img/license.png
      :align: center

      *License Agreement*

#. Select the **Destination folder** where you would like to install the OpenGeo Suite, and click :guilabel:`Next`.

   .. figure:: img/directory.png
      :align: center

      *Destination folder for the installation*

#. Select the name and location of the **Start Menu folder** to be created, and click :guilabel:`Next`.

   .. figure:: img/startmenu.png
      :align: center

      *Start Menu folder to be created*

#. Select the components you wish to install and click :guilabel:`Next`.

   .. figure:: img/components.png
      :align: center

      *Component selection*

#. You can install the OpenGeo Suite in one of two ways.:
  
     * :guilabel:`Run manually` - The OpenGeo Suite is run like a standard application.  This is useful for evaluating the software.
     * :guilabel:`Install as a service` - The OpenGeo Suite is integrated with Windows Services.  This is more secure, and is the preferred method of running in a production environment.  This will also launch the OpenGeo Suite automatically with Windows.

   If you are not sure which option to choose, select :guilabel:`Run manually`.

   .. figure:: img/installtype.png
      :align: center

      *Select the type of installation*

#. Enter a username and password for configuring GeoServer, and also the port that the OpenGeo Suite will respond on.  When finished, click :guilabel:`Next`.

      .. note:: Please make sure that no other applications are running on this port.

   .. figure:: img/creds.png
      :align: center

      *Enter credentials and port information*

#. Verify all the information and click :guilabel:`Back` to make any changes.  Click :guilabel:`Install` to perform the installation.

   .. figure:: img/ready.png
      :align: center

      *Verify all settings before continuing*

#. Please wait while the installation proceeds.

   .. figure:: img/install.png
      :align: center

      *Installation*

#. After installation, click :guilabel:`Finish` to start the OpenGeo Suite and launch the Dashboard.  If you would like to start the OpenGeo Suite at a later time, uncheck the box and then click :guilabel:`Finish`.

   .. figure:: img/finish.png
      :align: center

      *The OpenGeo Suite successfully installed*

For more information, please see the document titled **Getting Started**, which is available in the Start Menu at :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Getting Started`.

.. note:: The OpenGeo Suite must be running in order to view all documentation.


Upgrading
---------

It is possible to run two different versions of the OpenGeo Suite (ex: 1.0 and 1.1) simultaneously on the same machine.  This is useful for evaluation puposes, and to ensure that upgrading will not cause unwanted functionality.

If you wish to upgrade to a newer version, you should uninstall the current version (making sure to back up your data directory), and then install the newer version, overwriting the new data directory with the old.

Example upgrade (from 1.0 to 1.1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Stop OpenGeo Suite 1.0.

#. Back up the current data directory.

   .. note:: On Windows XP this is by default stored in :file:`C:\\Documents and Settings\\All Users\\Application Data\\OpenGeo\\OpenGeo Suite 1.0\\data_dir`).

#. Uninstall OpenGeo Suite 1.0.

#. Install OpenGeo Suite 1.1.

#. Stop OpenGeo Suite 1.1 (if it is running).

#. Overwrite data directory with saved data directory.

   .. note:: On Windows XP this is by default stored in :file:`C:\\Documents and Settings\\All Users\\Application Data\\OpenGeo\\OpenGeo Suite 1.1\\data_dir`).

#. Restart OpenGeo Suite 1.1.


Uninstallation
--------------

#. Navigate to :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Uninstall`

   .. note:: Uninstallation is also available via the standard Windows program removal workflow (i.e. **Add/Remove Programs** for Windows XP, **Installed Programs** for Windows Vista, etc.)

#. Click :guilabel:`Uninstall` to start the uninstallation process.

   .. figure:: img/uninstall.png
      :align: center

      *Ready to uninstall the OpenGeo Suite*

#. The uninstaller warn you to back up your data directory if you are upgrading.  When ready to continue, click :guilabel:`OK`.

   .. warning:: Deleting the data directory is *not* undoable!

   .. figure:: img/datadir.png
      :align: center

      *Backup your existing data directory if desired*

#. When done, click :guilabel:`Close`.

   .. figure:: img/unfinish.png
      :align: center

      *The OpenGeo Suite is successfully uninstalled*


Credits
-------

All text content created by OpenGeo and licensed under the `Creative Commons Share-Alike license <http://creativecommons.org/licenses/by-sa/3.0>`_.

All code is open source under various licenses including, but not limited to, the `GNU Public License <http://www.gnu.org/licenses/gpl.html>`_.

For More Information
--------------------

Please visit http://opengeo.org or email inquiry@opengeo.org .