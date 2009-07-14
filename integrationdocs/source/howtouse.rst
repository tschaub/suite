.. _howtouse:

How to Use
==========

This section will detail the steps necessary to go from simple shapefiles to a finished web map.

Import Your Data
----------------

The OpenGeo Suite comes with some data built in to GeoServer.  (See the section on :ref:`builtindemos` for more information.)  But to make *your* web application, you will need to first load your data into GeoServer.  GeoServer comes with an importer application to make this process easy.

#. First, start GeoServer if it is not already started.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> Start GeoServer`

#. Open the GeoServer Data Importer.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> GeoServer Data Importer`.

   .. note:: You can also navigate to the Data Importer from the main web admin page by first logging in and then clicking on the :guilabel:`Importer` link on the left side of the screen.  You will need to be logged in for that option to appear.

#. Your browser will open to the GeoServer login screen.  The default username and password is ``admin`` and ``geoserver``.  Click :guilabel:`Login` when done.

   .. figure:: img/login.png
      :align: center

      *Logging in to the GeoServer web admin interface*

#. On the next screen, enter a name for the project in the :guilabel:`Project prefix` box.  This name can be up to 10 characters, and may not contain spaces.

   .. note:: The :guilabel:`Project prefix` will be prefixed to the name of every shapefile you import into GeoServer.  For example, if you import a file named :file:`roads.shp`, and enter a prefix of ``usa``, the resulting layer in GeoServer will be called ``usa:roads``.

   .. figure:: img/importerblank.png
      :align: center

      *The Data Importer main page*

#. In the :guilabel:`Directory` box, enter the path to a directory that contains the shapefiles you wish to import.  You can also click :guilabel:`Browse...` to navigate to the folder.

   .. figure:: img/browse.png
      :align: center

      *Browsing for shapefiles on your local machine*

   .. warning:: If you installed GeoServer as a **Service**, GeoServer will not be able to read any folders outside of the existing data directory.  You must explicitly grant read access to the folder that contains teh shapefiles for the user "NETWORK SERVICE".

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

#. If you would like to see a preview of how a layer looks, click the :guilabel:`Preview` button next to that layer.  When finished you may close the browser.  Your data is now loaded into GeoServer.  If you wish to import more shapefiles from other directories, you may repeat this process.


Style Your Data (advanced)
--------------------------

By default, all layers of the same geometry type (points, lines, polygons) will have the same style.  You can customize these styles in the GeoServer web admin interface.  A knowledge of SLD (Styled Layer Descriptors) is required.  Future versions of this software will include **Styler**, a GUI styling application. 

.. note:: For more information on SLDs, please see the **Styling** section of the GeoServer documentation.

These instructions will change the color of the default point style (called "point") and save as a different style.  If you do not wish to change any styles, you may skip to the next section, :ref:`createyourmap`, below.

#. Open the GeoServer Web Admin if it is not already open.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> GeoServer Web Admin` or by opening a browser and navigating to http://localhost:8080/geoserver/web/ .

#. If you are not already logged in, do so.  (The upper right of the screen will say "Logged in as admin" if you are logged in.)  The default username and password is ``admin`` and ``geoserver``.

#. Click the :guilabel:`Styles` link on the left side of the screen.

   .. figure:: img/styles.png
      :align: center

      *The Styles section allows the viewing and editing of styles*

#. A list of the styles known to GeoServer is displayed.  Click :guilabel:`Add a new style`.

   .. figure:: img/listofstyles.png
      :align: center

      *The list of styles*

#. By default, the :guilabel:`point` style is populated in the style field.  Type in "pointgreen" in the :guilabel:`Name` field.  On line 20 of the style, replace "#FF0000" with "#00FF00" .  This will make the style identical to the default point style, except with a green point instead of a read point.

   .. figure:: img/pointgreen.png
      :align: center

      *Creating a style based off of the default point style*
 
#. When done, click :guilabel:`Submit`.

   .. figure:: img/stylesubmit.png
      :align: center

      *Submitting a new style*

#. The style "pointgreen" will be shown in the style list now.  To associate this style with an existing layer, click on the "Layers" link on the left side of the admin screen.

   .. figure:: img/layers.png
      :align: center

      *The Layers section allows layers to be configured*

#. In the list of layers, select the layer to associate with the newly created style.

   .. warning:: You must match the geometry type to the layer.  This example creates a point style, which can only be applied to a point layer.  If you mismatch the layer with the style, the layer will not display, and errors may occur.

   .. figure:: img/layerslist.png
      :align: center

      *The list of layers*

#. The next screen shows the information associated with that layer.  Click on the :guilabel:`Publishing` tab.

   .. figure:: img/layeredit.png
      :align: center

      *Configuring a layer*

#. Scroll down to the :guilabel:`Default style` dropdown box and select the "pointblue" style.

   .. figure:: img/styleselect.png
      :align: center

      *Selecting another style*

#. When done scroll to the bottom and click :guilabel:`Save`.

#. If you wish to preview how the layer looks with the new style, click on :guilabel:`Layer Preview` on the left side of the web admin screen, scroll down to the layer, and then click on the :guilabel:`Openlayers` link next to the layer.

   .. figure:: img/layerpreview1.png
      :align: center

      *The Layer Preview page*

   .. figure:: img/layerpreview2.png
      :align: center

      *The Layer Preview page*


.. _createyourmap:

Create Your Map
---------------

Now that you have your data imported and styled, you can now organize your layers and compose them into a finished map.  GeoExplorer allows creation of web mapping applications based on layers served through GeoServer.

#. Run GeoExplorer.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoExplorer --> GeoExplorer` or by opening a web browser and navigating to http://localhost:8080/geoserver/www/GeoExplorer .

   .. todo:: Screenshot of GX

#. By default, you will see a basemap of the world.  To add your layers, click on the green plus icon in the top left corner of the screen.

   .. todo:: Screenshot of plus

#. A list of layers from GeoServer will be displayed.  Select the layers you wish to add, then click :guilabel:`Add layers`.  (You can use Ctrl-click to select multiple layers.)  Click :guilabel:`Done` when finished.

   .. todo:: Screenshot of Add layers

#. The layers will be added to the map.  Use the toolbar at the top of the screen to compose your map.

   .. todo:: Screenshot of something

   .. note:: For more information on GeoExplorer, please see the included GeoExplorer Documentation. 


Export Your Map
---------------

After you have created the map and customized it to look just as you like it, you can save/export the map via a bookmarkable shortcut.

#. Click on the :guilabel:`Bookmark` icon.

   .. todo:: Screenshot of bookmark icon

#. A URL will be displayed.  Copy and save this URL to regenerate this map at aleter time.

   .. todo:: Screenshot of URL
 
You can also embed your map in a webpage.

#. Click on the :guilabel:`Export Map` icon. 

   .. todo:: Screenshot of Export Map icon

#. In the dialog box that follows, select the layers that you wish to include in this embedded map.  Click :guilabel:`Next` when done.

   .. todo:: Screenshot of Export Map box

#. The next screen will show HTML code that can be pasted into a webpage in order to embed the map.

   .. todo:: Screenshot of Export Map HTML

