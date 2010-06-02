============
Introduction 
============
The process for data editing can be divided into two categories of operations: preparing and modifying data.  Data preparation involve querying a select dataset by location or attribute, while data modification involves generating new spatial features.  

Before diving into the specifics of these operations, we introduce the basics concepts of the user interface and managing layers. For those familiar with GeoExplorer's interface, feel free to skip to the :ref:`preparing` section.

Workspace Overview
------------------

You can examine and manipulate your data using various controls, such as panels, buttons, and windows. GeoEditor arranges these elements into a single, integrated workspace.   

The :guilabel:`Layers panel` lists selected layers with associated legend in the :guilabel:`Legend` tab. You can use the Layers panel to manage display options. 

The :guilabel:`Tools panel` contains tools for selecting, editing, and viewing layers. To view information about any tool, position the pointer over it. The name of the tool appears in a tool tip below the pointer.

The :guilabel:`Map window` displays the map you’re working on.  Maps windows can display layers and/or query results along with controls for modifying and deleting features.

The :guilabel:`Query panel` displays query options and results for the currently selected layer. 


Layers panel
```````````` 
You can add layers by clicking on the (+) button in the layers panel. 
The ``Available Layers`` dialog lists all layers on the current :term:`WMS` server. 
To display meta information about the layer, click on the (+) next to each layer. Double click a 
layer row in the grid, or select layers and click ``Add Layers`` to add them to the map.

..note:: Unlike GeoExplorer, GeoEditor does not provide a direct way to access layers from a 
different WMS server. 

You can manage the composition of your layers through the :guilabel:`Layers` list. Right click 
on a layer to zoom to a layer extent, remove a layer from the layer list, or view layer properties.  

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

Tool Panel
``````````
The :guilabel:`Tools panel` contains a number of controls, including access to adding a new 
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

