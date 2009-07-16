.. _styleyourdata:

Style Your Data
===============

By default, all layers of the same geometry type (points, lines, polygons) will have the same style.  You can customize these styles in the GeoServer web admin interface.  A knowledge of SLD (Styled Layer Descriptors) is required.  Future versions of this software will include **Styler**, a GUI styling application. 

.. note:: For more information on SLDs, please see the **Styling** section of the GeoServer documentation.

These example instructions will change the color of the default point style (called "point") and save it as a different style.  If you would like to keep the default styles, you may skip to the next section, :ref:`composeyourmap`.

#. Open the GeoServer Web Admin if it is not already open.  You can do this by going to the :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> GeoServer --> GeoServer Web Admin` or by opening a browser and navigating to http://localhost:8080/geoserver/web/ .

#. If you are not already logged in, do so.  (The upper right of the screen will say :guilabel:`Logged in as admin` if you are logged in.)

   .. note:: The default username and password is ``admin`` and ``geoserver``.

#. Click the :guilabel:`Styles` link on the left side of the screen.

   .. figure:: img/styles.png
      :align: center

      *The Styles section allows styles to be edited*

#. A list of the styles known to GeoServer is displayed.  Click :guilabel:`Add a new style`.

   .. figure:: img/listofstyles.png
      :align: center

      *The list of styles*

#. By default, the :guilabel:`point` style is populated in the style field.  Type in ``pointgreen`` in the :guilabel:`Name` field.  On **line 20** of the style, replace ``#FF0000`` with ``#00FF00``.  This will change the color of the default point style from red to green.

   .. figure:: img/pointgreen.png
      :align: center

      *Creating a style based off of the default point style*
 
#. When done, click :guilabel:`Submit`.

   .. figure:: img/stylesubmit.png
      :align: center

      *Submitting a new style*

#. The style ``pointgreen`` will be shown in the style list now.  To associate this style with an existing layer, click on the :guilabel:`Layers` link on the left side of the admin screen.

   .. figure:: img/layers.png
      :align: center

      *The Layers section allows layers to be configured*

#. In the list of layers, select the layer to associate with the newly created style.

   .. warning:: You must match the geometry type to the layer.  This example creates a point style, which can only be applied to a point layer.  If you mismatch the layer with the style, the layer will not display and errors may occur.

   .. figure:: img/layerslist.png
      :align: center

      *The list of layers*

#. The next screen shows the information associated with that layer.  Click on the :guilabel:`Publishing` tab.

   .. figure:: img/layeredit.png
      :align: center

      *Configuring a layer*

#. Scroll down to the :guilabel:`Default style` dropdown box and select the ``pointgreen`` style.

   .. figure:: img/styleselect.png
      :align: center

      *Selecting another style*

#. When done, scroll to the bottom and click :guilabel:`Save`.

#. If you wish to preview how the layer looks with the new style, click on :guilabel:`Layer Preview` on the left side of the screen, scroll down to the layer you wish to preview, and then click on the :guilabel:`OpenLayers` link next to the layer.

   .. figure:: img/layerpreview1.png
      :align: center

      *The Layer Preview page*

   .. figure:: img/layerpreview2.png
      :align: center

      *Previewing the layer using OpenLayers*
