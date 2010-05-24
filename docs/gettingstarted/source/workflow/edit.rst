.. _workflow.edit:

Step 3: Edit Your Data
======================

.. note:: This step is optional.  If you don't wish to edit any of your existing data sources, you can skip to the next section, :ref:`workflow.style`.

The OpenGeo Suite contains an application called **GeoEditor** that allows for editing of geospatial data served through GeoServer.

#. To launch GeoEditor, first, make sure the OpenGeo Suite is running.  You can do this by clicking on the :guilabel:`Start` button in the :ref:`dashboard`.

#. Launch GeoEditor by clicking on the :guilabel:`GeoEditor` link.

   (IMAGE)

#. Your browser will open, and a base map will be displayed.  To edit a layer, click on the green plus icon (:guilabel:`Add Layers`) on the top left of the screen.

   (IMAGE)

#. A list of all the layers served through GeoServer will be displayed.  Select a shapefile to edit (or select more than one), click :guilabel:`Add Layers`, then click :guilabel:`Done`.

   (IMAGE)

#. Click on the layer name in the :guilabel:`Layers` panel, then right-click and select :guilabel:`Zoom to Layer Extent`.

   (IMAGE)

#. To select that layer to be edited, select that layer name in the :guilabel:`Layer` drop down box in the :guilabel:`Feature Query` panel at the bottom left of the browser window.

   .. warning:: Just selecting the layer in the :guilabel:`Layers` panel is not sufficient.

   (IMAGE)

Edit attribute data
-------------------

#. To edit attribute data for the selected layer, click on the :guilabel:`Get Feature Info` button (the blue circle with the white 'i') in the menu bar.

   (IMAGE)

#. Click on a feature.

#. A popup will display, showing the attributes of this feature.  Click the :guilabel:`Edit` button and then click on any of the fields to change the value.

   (IMAGE)

#. When done, click :guilabel:`Save`.

   (IMAGE)

Create a feature
----------------

#. To create a new feature in the selected layer, click on the :guilabel:`Create a new feature` icon.

   (IMAGE)

#. Click anywhere in the main window to start drawing the feature.

   (IMAGE)

#. Double-click to finish creation.  

   (IMAGE)

#. Afterwards, a popup will display, where attribute data can be entered.  Enter any attribute data, then click :guilabel:`Save`.

   (IMAGE)

Delete a feature
----------------

#. To delete a feature, click on the :guilabel:`Get Feature Info` button (the blue circle with the white 'i') in the menu bar.

   (IMAGE)

#. Click on a feature.

   (IMAGE)

#. A popup will display, showing the attributes of this feature.  Click the :guilabel:`Delete` button.

   (IMAGE)

#. A confirmation popup will display.  Click :guilabel:`Yes` to confirm deletion.

   (IMAGE)

.. note:: For more information on GeoEditor, please see the GeoEditor Documentation. You can access this by clicking the :guilabel:`GeoEditor Documentation` link in the :ref:`dashboard`.