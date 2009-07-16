.. _importyourdata:

Import Your Data
================

The OpenGeo Suite comes with some data built in to GeoServer.  (See the section on :ref:`builtindemos` for more information.)  But to make *your* web application, you will need to first load your data into GeoServer.  GeoServer comes with an importer application to make this process easy.

#. First, start GeoServer if it is not already started.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> Start GeoServer`

#. Open the GeoServer Data Importer.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> GeoServer Data Importer`.

   .. note:: You can also navigate to the Data Importer from the main web admin page by first logging in and then clicking on the :guilabel:`Importer` link on the left side of the screen.  You will need to be logged in for that option to appear.

#. Your browser will open to the GeoServer login screen.  The default username and password is ``admin`` and ``geoserver``.  Click :guilabel:`Login` when done.

   .. figure:: img/login.png
      :align: center

      *Logging in to the GeoServer web admin interface*

#. On the next screen, enter a name for the project in the :guilabel:`Project prefix` box.  This name can be up to ten characters in length, and may not contain spaces.

   .. note:: The :guilabel:`Project prefix` will be prefixed to the name of every shapefile you import into GeoServer.  For example, if you import a shapefile named :file:`roads.shp`, and enter a prefix of ``usa``, the resulting layer in GeoServer will be called ``usa:roads``.

   .. figure:: img/importerblank.png
      :align: center

      *The Data Importer main page*

#. In the :guilabel:`Directory` box, enter the path to a directory that contains the shapefiles you wish to import.  You can also click :guilabel:`Browse...` to navigate to the folder.

   .. figure:: img/browse.png
      :align: center

      *Browsing for shapefiles on your local machine*

   .. warning:: If you installed GeoServer as a **Service**, GeoServer will not be able to read any folders outside of the existing data directory.  You must explicitly grant read access to the folder that contains the shapefiles for the user "NETWORK SERVICE".

      For more information on how to grant permissions, please see the following article:  http://www.microsoft.com/windowsxp/using/security/learnmore/accesscontrol.mspx

#. When done, click :guilabel:`Import data`.

   .. figure:: img/importerfilledin.png
      :align: center

      *The Data Importer with project information entered*

#. You will see a progress bar indicating that the shapefiles are being loaded into GeoServer.

   .. figure:: img/progressbar.png
      :align: center

      *The Data Importer showing the progress of the import*

#. When finished, a list of the shapefiles will be displayed, along with details and errors (if any).  Each shapefile will correspond to a layer.

   .. figure:: img/results.png
      :align: center

      *The Data Importer results page*

#. If you would like to see a preview of how a layer looks, click the :guilabel:`Preview` button next to that layer.  When finished you may close the browser.  Your data is now loaded into GeoServer.

If you wish to import more shapefiles from other directories, you may repeat this process.