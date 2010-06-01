============
Introduction 
============
The process for data editing can be divided into two categories of operations: querying data and transforming data.  Data queries involve investigating datasets by location or attribute, while data transformation involves generating new spatial relationships.  

Before diving into the specifics of these operations, we introduce some of the basics concepts of the user interface.  If you're familiar with GeoExplorer feel free to skip to querying data. 


Interface Overview
------------------

GeoEditor is divided into five major panels:

#. On the lower left hand corner is the :guilabel:`Feature Query` panel for searching 
within data layers.

#. Towards the right, the :guilabel:`Search Results` panel lists the first 100 results of a 
feature query along with options for preview in the map panel.

#. The map panel provides a preview of layers and/or query results along with controls for 
modifying and deleting features.

#. The button bar on top contains a number of controls, including access to adding a new 
feature.  The following tables outlines these buttons and associated functionality.

    .. list-table::
       :widths: 15 15 70 

       * - **Button**
         - **Name**
         - **Description**
       * - .. image:: /images/measure.png 
         - Measure
         - An expandable button for measuring distance and area when active. To measure, click on the map, drawing a line for distance or a polygon for area measurement. Freehand measuring can be activated by pressing and holding the shift key. Double click on the map to draw the last vertex of the measurement line or polygon. The distance or area will be displayed in a small popup.
       * - .. image:: /images/zoomin.png
         - Zoom-In
         - Zoom-in by one zoom level.
       * - .. image:: /images/zoomout.png
         - Zoom-Out
         - Zoom-out by one zoom level.   
       * - .. image:: /images/previousextent.png
         - Zoom to previous extent
         - Zoom to the extent you were previously viewing.
       * - .. image:: /images/nextextent.png
         - Zoom to next extent
         - After using the ``Zoom to previous extent`` button, click to zoom to the next extent.
       * - .. image:: /images/extent.png
         - Zoom to visible extent
         - Click to view the largest possible area.

#. In order to easily manage layer previews, the :guilabel:`Layer` and :guilabel:`Legend` 
panel provides a list of layers and legends, respectively.   

Adding Layers
-------------

As in GeoExplorer, you can preview layers by clicking on the (+) button in the layers panel. 
The ``Available Layers`` dialog lists all layers available on the :term:`WMS` server. 
To display meta information about the layer, click on the (+) next to each layer, Double click a 
layer row in the grid, or select layers and click ``Add Layers`` to add them to the map.

..note:: Unlike GeoExplorer, GeoEditor does not provide a direct way to access layers from a 
different WMS server.  

Managing Layers
---------------

You can manage the composition of your layers through the :guilabel:`Layers` list. Right click 
on a layer for a context menu.  Here you can zoom to the layer extent, remove a layer from the 
layer list, or view layer properties.  

    .. list-table::
       :widths: 15 85 

       * - **Button**
         - **Description**
       * - .. image:: /images/managing1.png
         - Click (+) to add layers.
       * - .. image:: /images/managing2.png
         - Click (-) to remove the currently selected layer.
       * - .. image:: /images/managing3.png
         - For a selected later, presents *About* and *Display* information.
  
When organizing layer order, first select a layer and then drag and drop the layer in the hierarchy. To toggle visibility you can either use the checkboxes or double click a layer


