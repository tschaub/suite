.. _importyourdata:

Step 1: Import Your Data
========================

The OpenGeo Suite comes with some data preloaded.  (See the section on :ref:`builtindemos` for more information.)  But to create *your* web map, you will need to first load your data into GeoServer.  GeoServer comes with a Data Importer application to make this process easy.

#. First, start the OpenGeo Suite if it is not already started.  You can do this by clicking on the :guilabel:`Start` button in the Dashboard.

#. Open the GeoServer Layer Importer.  You can do this in the Dashboard by clicking :guilabel:`Import Layers`.


#. Your browser will open.  Select the type of data you wish to import.

#. You may be asked to log into GeoServer.  Enter the username and password you chose when installing the OpenGeo Suite.  (The default username and password is ``admin`` and ``geoserver``.)  Click :guilabel:`Login` when done.

   .. figure:: img/login.png
      :align: center

      *Logging in to the GeoServer Admin interface*

#. Enter the path to a directory that contains the shapefiles you wish to import.  You can also click :guilabel:`Browse...` to navigate to the folder.

   .. figure:: img/importerblank.png
      :align: center

      *The Data Importer main page*

   .. figure:: img/browse.png
      :align: center

      *Browsing for shapefiles on your local machine*

#. When done, click :guilabel:`Import data`.

   .. figure:: img/importerfilledin.png
      :align: center

      *The Layer Importer with project information entered*

#. You will see a progress bar indicating that the shapefiles are being loaded into GeoServer.

   .. figure:: img/progressbar.png
      :align: center

      *The Data Importer showing the progress of the import*

#. When finished, a list of the shapefiles will be displayed, along with details and issues (if any).  Each shapefile will correspond to a layer.

   .. figure:: img/results.png
      :align: center

      *The Layer Importer results page*

#. If you would like to see a preview of how a layer looks, click the :guilabel:`Preview` button next to that layer.  If you would like to view a layer's configuration, click the Name of the layer.

When finished you may close the browser.  Your data is now loaded into GeoServer.  If you wish to import more shapefiles from other directories, you may repeat this process.