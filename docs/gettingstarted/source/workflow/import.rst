.. _workflow.import:

Step 3: Import Your Data
========================

The OpenGeo Suite comes with some data preloaded.  (See the section on :ref:`builtindemos` for more information.)  But in order to create *your* web map, you will need to first serve your data using GeoServer.  GeoServer comes with a **Layer Importer** application to make this process easy.

.. note:: The Layer Importer can import data from shapefiles, PostGIS databases, and ArcSDE/Oracle Spatial databases (with appropriate plugin files installed).  This example workflow uses the PostGIS data from the previous step, however, if you skipped that step, you can import shapefiles here in exactly the same way.

#. First, make sure the OpenGeo Suite is running.  You can do this by clicking on the :guilabel:`Start` button in the Dashboard.

#. Open the GeoServer Layer Importer.  You can do this in the Dashboard by clicking :guilabel:`Import Layers`.

#. Your browser will open.  Select the type of data you wish to import.

   .. note:: In order to enable ArcSDE and Oracle Spatial support in the Layer Importer, external files are required from your current database installation.  For ArcSDE, the files ``jsde*.jar`` and ``jpe*.jar`` are required.  For Oracle spatial, ``ojdbc*.jar`` is required.  Copy the file(s) into ``webapps/geoserver/WEB-INF/lib`` from the root of your installation, and then restart.  If successful, you will see extra options on this page.

(IMAGE) 

#. You may be asked to log into GeoServer.  Enter your current username and password and click :guilabel:`Login`.  (The default username and password is ``admin`` and ``geoserver`` although the :ref:`dashboard.prefs` page will show the current credentials.)

   .. figure:: img/login.png
      :align: center

      *Logging in to the GeoServer admin interface*

#. First select a :guilabel:`Workspace` from the list.  A workspace is the name for a group of layers, and usually signifies a project name.  You may wish to create a new workspace if you'd like, by clicking on :guilabel:`create a new workspace`.

      .. warning:: The workspace name should not contain spaces.

(IMAGE)

#. Select a :guilabel:`Name` for the GeoServer store.  Since all we are doing at this step is connecting to the PostGIS database, this name can be whatever you'd like it to be.

#. Enter a description in the :guilabel:`Description` field.  This too can be whatever you'd like it to be.

#. Under :guilabel:`Connection Parameters`, enter the following information:

      * - **Host**
        - localhost
      * - **Port**
        - 54321
      * - **Database**
        - [your user name on your host operating system]
      * - **User name**
        - postgres
      * - **Password**
        - [blank]

#. When finished, click :guilabel:`Next`.

(IMAGE)

#. On the next screen, a list of spatial tables will be displayed.  This list should correspond to the shapefiles that you loaded in :ref:`workflow.load`.  Check all of the boxes that you would like to serve with GeoServer and click :guilabel:`Import Data`.

(IMAGE)

#. A progress bar will display, loading each table into GeoServer.  When finished, the results will be displayed.  If there were any errors, they will be described in this list with a yellow exclamation mark.  You may see a preview of how each layer looks in either OpenLayers, Google Earth, or Styler, by clicking the appropriate link in the :guilabel:`Preview` column next to that layer.  If you would like to view a layer's configuration, click the :guilabel:`Name` of the layer.

(IMAGE)

Your database tables have been turned into GeoServer layers.  If you wish to import data from other sources, you may repeat this process.