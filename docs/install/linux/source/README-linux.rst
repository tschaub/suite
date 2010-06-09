Installing the OpenGeo Suite
============================

This document will describe how to install the OpenGeo Suite.  More detailed operating instructions are available once the software is installed.


Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* **Operating System**: Ubuntu 9.10, Redhat 5, CentOS 5, Fedora 11 (32bit)
  * **Note**: The Dashboard is not available on 64bit systems, but the other components of the Suite run on 64bit systems.
* **Memory**: 512MB minimum (1GB recommended)
* **Disk space**: 500MB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported (Internet Explorer 6+, Firefox 3+, Chrome 2+, Safari 3+)
* **Permissions**: Runs in a user account; superuser not required

Installation
------------

.. note:: The installation process runs in a terminal.

#. Begin the install by executing the :file:`OpenGeoSuite-2.0.0.bin` file in a shell:

   .. code-block:: bash

     sh OpenGeoSuite-2.0.0.bin

#. The archive will verify its integrity, and then ask if you wish to proceed (default is Yes)::

     Would you like to proceed with installing OpenGeo Suite? [Y|n]: 

#. Read and accept the License Agreement (default is Yes)::

     Do you accept the license agreement? [Y|n]:

#. Choose the installation directory.  The default is in the ``$HOME`` directory::

     Choose an installation directory [/home/user/opengeosuite-2.0.0]:

#. Choose if the OpenGeo Suite should include ArcSDE support (default is No):

   .. note:: You will be prompted for additional required libraries later in the installation.

   ::

     Would you like to include additional support for ArcSDE? [y|N]:

#. Choose if the OpenGeo Suite should include Oracle Spatial support (default is No):

   .. note:: You will be prompted for additional required libraries later in the installation.

   ::

     Would you like to include additional support for Oracle? [y|N]:

#. Choose if you would like to create links to executable files (default is Yes)::

     Would you like to create links to executable files? [Y|n]:
     
#. If you selected "yes", choose the directory where the links will be created.  The default is ``$HOME/bin``::

     What directory should links be created in? [/home/user/bin]:
      
#. If this directory does not exist, you will be asked if you want to create it::
   
     /home/user/bin does not exist. Would you like to create it now? [Y|n]:
            
#. The installer will provide a summary and ask for confirmation::
   
      Installation summary:

	     Installation directory: 	 /home/user/opengeosuite-2.0.0
	     Install ArcSDE support: 	 No
	     Install Oracle support: 	 No
	     Install executables:        /home/user/bin

      Proceed with installation? [Y|n]: 

#. The installation will begin.  

#. If you chose to add support for ArcSDE, the installer will ask you for the location of the necessary external libraries::

     The ArcSDE extension requires the Java ESRI client libraries to function.
     Where are the libraries located on your system? [Leave blank to skip]:

#. If you chose to add support for Oracle, the installer will ask you for the location of the necessary external libraries::

     The Oracle extension requires the Oracle JDBC driver to function.
     Where is ojdbc jar located on your system? [Leave blank to skip]:

#. The installation is complete.

#. To run the Dashboard, navigate to ``$HOME/bin`` and type:
 
   .. code-block:: bash

     $ ./opengeo-dashboard

   .. note:: The Dashboard requires X11 or equivalent windowing environment.

#. To start or stop the OpenGeo Suite, navigate to ``$HOME/bin`` and type:

   .. code-block:: bash

     $ ./opengeo-suite start
     $ ./opengeo-suite stop  


Uninstallation
--------------

.. note:: Please make sure the OpenGeo Suite is offline and the Dashboard is closed before uninstalling.

#. Navigate to the OpenGeo Suite installation directory:

   .. code-block:: bash

     $ cd /home/user/opengeosuite-2.0.0/suite

#. Execute the uninstall.sh script

   .. code-block:: bash

     $ ./uninstall.sh


For More Information
--------------------

Please visit http://opengeo.org or see the documentation included with this software.
