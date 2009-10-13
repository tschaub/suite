.. _styleyourlayers:

Style Your Layers
=================

The Layer Importer will generate basic styles for each layer loaded in GeoServer.  To alter and improve the styling of your layers, use the **Styler** application.  

These example instructions will change the color of one of the default styles.  If you would like to keep the default styles, you may skip to the next section, :ref:`composeyourmap`.

.. note:: For more information on Styler, please see the Styler Documentation.  you can access this by clicking the :guilabel:`Styler Documentation` link in the Dashboard or by navigating to `Start Menu --> Programs --> OpenGeo Suite --> Documentation --> Styler`.

#. Launch Styler.  Styler can be launched from the :guilabel:`Style Layers` link in the Dashboard or by navigating to menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Styler`.

   .. figure:: img/styler.png
      :align: center

#. A list of all the loaded layers in GeoServer will be displayed in the :guilabel:`Layers` column.  Select the layer you would like to style by clicking the radio button next to the layer name.  While styling your layer, you can show or hide other layers for context by checking or unchecking the boxes next to the layers.

   .. note:: Only one layer can be styled at a time.

   .. figure:: img/stylerselectlayer.png
      :align: center

      *Selecting a layer for styling*

#. Click on a feature of the layer that you are styling.  A window will pop up showing current style information including attributes and metadata.

   .. figure:: img/stylerfeatureinfo.png
      :align: center

      *Feature infrmation for a selected feature*

#. To change the style used for the layer, click on the rule in the pop up (under the heading :guilabel:`Rules used to render this feature`).

   .. figure:: img/editstyle1.png
      :align: center

      *The style edit window*

#. A style editor window is launched.  Change the style as you see fit, selecting from symbol, size, color, opacity, and many other options.

   .. note:: Please see the Styler Documentation for details on what can be styled using Styler.
 
   .. figure:: img/editstyle2.png
      :align: center

      *Style parameters changed*

#. Click :guilabel:`Save` to apply and view your change on the main map.

   .. figure:: img/styleredited.png
      :align: center

      *The newly restyled layer*

#. Repeat this process for every layer that you wish to style.

   .. note:: Any changes made through Styler will immediately be live and will persist.
