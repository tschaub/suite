.. _importyourdata:

Step 1: Import Your Data
========================

The OpenGeo Suite comes with some data preloaded.  (See the section on :ref:`builtindemos` for more information.)  But to create *your* web map, you will need to first load your data into GeoServer.  GeoServer comes with a **Layer Importer** application to make this process easy.

.. note:: The Layer Importer can import data from shapefiles, PostGIS databases, and ArcSDE/Oracle Spatial databases (with appropriate plugin files installed).  This example workflow uses shapefiles; some of the field names may be slightly different when importing from different sources.

#. First, start the OpenGeo Suite if it is not already started.  You can do this by clicking on the :guilabel:`Start` button in the Dashboard.

#. Open the GeoServer Layer Importer.  You can do this in the Dashboard by clicking :guilabel:`Import Layers`.

#. Your browser will open.  Select the type of data you wish to import.

   .. note:: In order to enable ArcSDE and Oracle Spatial support in the Layer Importer, external files are required from your current database installation.  For ArcSDE, the files ``jsde*.jar`` and ``jpe*.jar`` are required.  For Oracle spatial, ``ojdbc*.jar`` is required.  Copy the file(s) into ``webapps/geoserver/WEB-INF/lib`` from the root of your installation, and then restart.  If successful, you will see extra options on this page.

   .. figure:: img/adddatasource.png
      :align: center

      *Selecting a data source for import*

#. You may be asked to log into GeoServer.  Enter your current username and password and click :guilabel:`Login`.  (The default username and password is ``admin`` and ``geoserver``.)

   .. figure:: img/login.png
      :align: center

      *Logging in to the GeoServer Admin interface*

#. Fill out the information form.  :guilabel:`Workspace` is the name for a group of layers, and usually signifies a project name.  :guilabel:`Name` is the name of the group of layers you are importing (this can be the same as the workspace).  :guilabel:`Description` is a human-readable text field describing your data source.  Finally, :guilabel:`Directory` is the path to a directory that contains the data you wish to import.


   .. figure:: img/importerblank.png
      :align: center

      *The Layer Importer main information page*

#. You may create a workspace name if you'd like.

   .. warning:: The workspace name should not contain spaces.

   .. figure:: img/workspacecreate.png
      :align: center

      *The Layer Importer main information page*

#. You can also click :guilabel:`Browse...` to navigate to a directory.

   .. figure:: img/browse.png
      :align: center

      *Browsing for shapefiles on your local machine*

#. When done, click :guilabel:`INext`.

   .. figure:: img/importerfilledin.png
      :align: center

      *The Layer Importer with project information entered*

#. The Importer will return a list of all the layers found.  Uncheck any you don't wish to load and select :guilabel:`Import Data`.

   .. figure:: img/selectresources.png
      :align: center

      *Selecting or unselecting the data to import*

#. You will see a progress bar indicating that the shapefiles are being loaded into GeoServer.

   .. figure:: img/progressbar.png
      :align: center

      *Showing the progress of the import*

#. When finished, a list of layers will be displayed, along with details and issues (if any).

   .. figure:: img/results.png
      :align: center

      *The Layer Importer results page*

#. You may see a preview of how a layer looks in either OpenLayers, Google Earth, or Styler, by clicking the appropriate link in the :guilabel:`Preview` column  next to that layer.  If you would like to view a layer's configuration, click the :guilabel:`Name` of the layer.

Your data is now loaded into GeoServer.  If you wish to import data from other sources, you may repeat this process.