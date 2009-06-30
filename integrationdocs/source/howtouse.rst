.. _howtouse:

How to Use
==========

This section will deatil the steps necessary to go from simple shapefiles to a finished web map.

Import Your Data
----------------

This version of GeoServer comes with some data built in.  (See the section on :ref:`builtindemos` for more information.)  But to make your web application, it is necessary to first load your own data into GeoServer.  GeoServer comes with an importer application to make this process easy.

#. First, start GeoServer if it is not already started.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> Start GeoServer`

   .. todo: Screenshot for starting GS

#. Navigate to the GeoServer Admin Page.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> GeoServer Web Admin` or by opening a web browser and navigating to http://localhost:8080/geoserver/web .

   .. todo: Screenshot for starting GS Admin

#. Log in to GeoServer.  You can do this in the top right corner of the screen.  The default username and password is ``admin`` and ``geoserver``.  Click :guilabel:`Submit` when done.

   .. todo: Screenshot for logging in

#. Once logged in, you should see a link on the left side of the screen for :guilabel:`Importer`.  Click that link to launch the Data Importer.

   .. todo: Screenshot for Importer link

#. On the Mass Layer Importer screen, enter a name for the project in teh :guilabel:`Project Name` box.  This name can be up to 10 characters, and may not contain spaces.  In the box named :guilabel:`Directory`, type in the path to a directory that contains the shapefiles that you want to import.

   .. todo: Figure out the specifics of importing.

#. When done, click :guilabel:`Import`.

#. You will see a progress bar indicating that the shapefiles are being loaded into GeoServer.  When finished, a list of the shapefiles will be displayed, along with their details and whether they imported successfully.

#. If you would like to see a preview of how each layer looks, click the :guilabel:`Preview` button next to the layers you wish to view.  When finished click :guilabel:`Finish`.


Style Your Data
---------------

Your data will at first be styled with generic styles.  You can customize each layer's style using the Styler application.

#. Open up the Styler application.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Styler` or by opening a web browser and navigating to http://localhost:8080/geoserver/www/styler .

   .. note:: GeoServer must be turned on for Styler to work.

   .. todo:: Are these instructions for Styler correct?

   .. todo:: Screenshot for Styler

#. ...

#. Profit!

   .. todo:: Flesh Styler instructions out.


Create Your Map
---------------

Now that you have your data imported and styled, you can now put it all together into a map.  GeoExplorer allows creation of web mapping applications based on data served through GeoServer.

#. Open up GeoExplorer.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoExplorer` or by opening a web browser and navigating to http://localhost:8080/geoserver/www/GeoExplorer .

   .. todo:: Screenshot of GX

#. ...

#. More profit!

   .. todo:: Flesh GX instructions out.

Export Your Map
---------------

After you have created the map to look just as you like it, you can save the map position into a bookmarkable shortcut.

#. ...

#. Even more profit!

   .. todo:: Flesh export instructions out.