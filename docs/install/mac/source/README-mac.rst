Installing the OpenGeo Suite
============================

This document will discuss how to install the OpenGeo Suite.  More detailed operating instructions are available once the software is installed.


Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* **Operating System**: 10.5 Leopard, 10.6 Snow Leopard
* **Memory**: 1GB minimum (higher recommended)
* **Disk space**: 400MB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported (Internet Explorer 6+, Firefox 3+, Chrome 2+, Safari 3+)
* **Permissions**: Administrative rights

Installation
------------
#. Double click to mount the :file:`OpenGeoSuite-1.0.dmg` file.  Inside the mounted image, double click on :file:`OpenGeo Suite.mpkg`

    .. figure:: img/files.png
       :align: center

       *The contents of the mounted image*

#. At the **Welcome** screen, click :guilabel:`Continue`.

    .. figure:: img/welcome.png
       :align: center

       *Welcome screen*

#. Read the **License Agreement**. To agree to the license, click :guilabel:`Continue` and then :guilabel:`Agree`.

      .. figure:: img/license.png
         :align: center

         *License Agreement*

#. To install the Suite on your hard drive click :guilabel:`Install`.  You will be prompted for your administrator password.  

    .. figure:: img/directory.png
       :align: center

       *Destination selection*

#. Please wait while the installation proceeds.

    .. figure:: img/install.png
       :align: center

       *Installation*
      
#. You have successfully installed the OpenGeo Suite!   The OpenGeo Dashboard will automatically start, allowing you to manage and launch the OpenGeo Suite.

    .. figure:: img/success.png
       :align: center

       *The OpenGeo Suite successfully installed*

For more information, please see the document titled **Getting Started**, which is available from the Dashboard, or inside the OpenGeo Suite package contents folder:

`<file:///Applications/OpenGeo%20Suite.app/Contents/Resources/Java/webapps/docs/gettingstarted/index.html>`_

.. note:: The OpenGeo Suite must be online in order to view documentation from the Dashboard.  If you would like to view the documentation when the Suite is offline, please use the file link above.

        
Uninstallation
--------------
#. Before uninstalling, make sure the OpenGeo Suite is offline.  You can turn off the Suite from any page on the dashboard, by clicking the :guilabel:`Stop` button.

    .. figure:: img/offline.png
        :align: center

        *Turning off the OpenGeo Suite*   
   
#. Shutdown the Dashboard by quitting the application.  From within the Dashboard, navigate to :menuselection:`OpenGeo Dashboard --> Quit OpenGeo Dashboard` or use the keyboard shotcut :guilabel:`Command-Q`.

#. To run the uninstaller, open a Terminal window by going to :menuselection:`Applications --> Utilities --> Terminal`.

#. From the terminal window, run the uninstaller shell script by typing the following.  

    .. code-block:: bash
        
        sudo /Applications/OpenGeo\ Suite.app/Contents/Resources/uninstaller.sh 
    
    .. note:: The command ``sudo`` means to execute a command as a superuser.  The ``sudo`` command allows you temporary superuser privileges.

    .. warning:: Make sure you are not in the :file:`/Applications/OpenGeo\ Suite.app` directory when running the uninstaller.  If unsure, type ``cd ~`` and press :guilabel:`Return` before running the above command.

#. You will be promoted to enter your root password.  This is the administrator password for your computer.

#.  When asked to continue, type ``y`` (for yes) then :guilabel:`Return`.

#. Your OpenGeo Suite was successfully uninstalled!

#. After uninstalling the OpenGeo Suite, we recommend removing the OpenGeo Suite configuration file.   To remove this file, type the following in the Terminal window.

    .. code-block:: bash
    
        rm -rf ~/.opengeo 
        
For More Information
--------------------

Please visit http://opengeo.org or see the documentation included with this software.
