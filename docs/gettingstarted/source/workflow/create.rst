.. _workflow.create:

Step 5: Create Your Map
=======================

Compose
-------

Now that your map layers are loaded and styled, you can organize and compose your layers into a map.  **GeoExplorer** allows you to create web maps based on layers served through GeoServer.

#. Run GeoExplorer.  You can do this by selecting :guilabel:`GeoExplorer` in the :ref:`dashboard`.

   .. figure:: img/geoexplorer.png
      :align: center

      *GeoExplorer*

#. You will see a basemap of the world.  To add your layers on top of this basemap, click on the :guilabel:`Add Layers` button (a green circle with a white plus) in the top left corner of the screen.

   .. figure:: img/addlayersbutton.png
      :align: center

      *This button will bring up the Add Layers dialog*

#. A list of layers from GeoServer will be displayed.  Select the layers you wish to add, then click :guilabel:`Add layers`.  (You can Ctrl/Cmd-click to select multiple layers.)  Click :guilabel:`Done` when finished.

   .. figure:: img/addlayersdialog.png
      :align: center

      *Selecting layers to add to your map*

   .. note:: You can also add layers served through another remote GeoServer, or any other compatible Web Map Server (WMS).  Click the :guilabel:`Add a new server` button to connect to another server.

#. The layers will be added to the map.  

   .. figure:: img/mapbefore.png
      :align: center

      *The initial view of layers*

#. Right-click on one of the layers and select :guilabel:`Zoom to layer extent` to zoom in to your layer content.

   .. figure:: img/mapzoombefore.png
      :align: center

      *The map zoomed in*

#. Use the toolbar at the top of the screen to compose your map.  Adjust the placement of layers by dragging them in the Layers panel.

   .. figure:: img/mapafter.png
      :align: center

      *The composed map*

Publish via URL Bookmark
------------------------

After you have composed your map in **GeoExplorer**, you can publish it via a URL bookmark.

#. Click on the :guilabel:`Save Map` icon.

   .. figure:: img/savemap.png
      :align: center

      *The Bookmark button will generate a URL*

#. A URL will be displayed.  Copy and save this URL to regenerate this map at a later time.

   .. figure:: img/savemapdialog.png
      :align: center

      *Copy this URL to save your map*
 
Publish via Embedded Map
------------------------

You can also publish your map by embedding it in a web page.

#. Click on the :guilabel:`Publish Map` icon.

   .. figure:: img/publishmap.png
      :align: center

      *The Publish Map button will generate a block of HTML*

#. A dialog will show HTML code that can be copied and included in a web page in order to embed the map.  You can change the values for the map size in the :guilabel:`Map Size` dropdown boxes, or by changing the :guilabel:`Height` and :guilabel:`Width` values.  The changes will automatically be reflected in the HTML.

   .. figure:: img/publishmapdialog.png
      :align: center

      *HTML for embedding a map*

#. Copy and paste this HTML code into a web page to embed your map.


For more information on GeoExplorer, please see the GeoExplorer Documentation by selecting :guilabel:`GeoExplorer Documentation` in the :ref:`dashboard`.