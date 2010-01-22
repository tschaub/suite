Installing the OpenGeo Suite
============================

This document will discuss how to install the OpenGeo Suite.  More detailed operating instructions are available once the software is installed.


Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* **Operating System**: Ubuntu 9.10, Redhat 5, Centos 5, Fedora 11 (each 32 and 64 bit)
* **Memory**: 512MB minimum (1GB recommended)
* **Disk space**: 300MB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported (Internet Explorer 6+, Firefox 3+, Chrome 2+)
* **Permissions**: Administrative rights

Installation
------------

#. Make the :file:`OpenGeoSuite-1.0r1.bin` file executable by setting the appropriate permisions.

   .. code-block::

      > chmod +x OpenGeoSuite-1.0r1.bin

#. Begin the install by executing the OpenGeoSuite-1.0r1.bin file

   .. code-block::

      > ./OpenGeoSuite-1.0r1.bin

#. Proceed with the install and read the **License Agreement** then click :guilabel:`I Agree`.

   .. code-block::

      Do you accept the license agreement? [Y|n]: Y

#. Choose the installation directory

   .. code-block::

      Choose an installation directory [/home/gisuser]:

#. Choose if the OpenGeo Suite should include ArcSDE support 

   .. code-block::

      Would you like to include additional support for ArcSDE? [y|N]:

#. Choose if the OpenGeo Suite should include Oracle support 

   .. code-block::

      Would you like to include additional support for Oracle? [y|N]:

#. Choose if you would like to create links to executable files 

   .. code-block::

      Would you like to create links to executable files? [Y|n]:
      
   If yes, select the directory where the links will be created   

   .. code-block::

      What directory should links be created in? [/home/gisuser/bin]:
      
   If the directory does not exist, create them.
  
   .. code-block::
   
   /home/gisuser/bin does not exist. Would you like to create it now? [Y|n]:    
            
#. The instaler will provide a summary and ask for confirmation.

   .. code-block::
   
      Installation summary: 

	     Installation directory: 	 /home/gisuser/opengeosuite-1.0-SNAPSHOT
	     Install ArcSDE support: 	 No
	     Install Oracle support: 	 Yes
	     Install executables: 		 /home/gisuser/bin

      Proceed with installation? [Y|n]: 

#. If you choose to add support for ArcSDE or Oracle, the installer will ask you for the location of the necessary libraries.

   .. code-block::
   
      The Oracle extension the Oracle JDBC driver to function. Where is ojdbc jar located on your system? [Leave blank to skip]:

#. The installation is complete.


Uninstallation
--------------

#. Change directory to the OpenGeo Suite installation directory

   .. code-block::
   
      >cd opengeosuite-1.0-SNAPSHOT/

#. Execute the uninstall.sh script

   .. code-block::
   
      >./uninstall.sh


For More Information
--------------------

Please visit http://opengeo.org or see the documentation included with this software.