.. _styler.getting_started:

===============
Getting Started
===============
This section contains an quick overview of Styler to get new users performing common tasks quickly 
and easily.  

  .. note:: In order to use Styler, we recommend defining a unique SLD to the layer. To create a 
      unique SLD for a layer, see the GeoServer documentation for :guilabel:`Styling a Map`.

#.  You can access Styler one of two ways.  Either open up `Styler
    <http://localhost:8080/geoserver/www/Styler/index.html>`_ in your
    browser or click a layer's :guilabel:`Styler` view from GeoServer's :guilabel:`
    Layer Preview` page.

    .. figure:: images/getting_started1.png
       :align: center
       :width: 600px
       
       *Selecting Styler from the Layer Preview page*

    .. note:: Styler can run on any HTTP server, like Apache, by 
              unpacking Styler to a web accessible path on your server.

#.  Welcome to :guilabel:`Styler`!

    .. figure:: images/getting_started2.png
       :align: center
       :width: 600px
       
       *View of Styler with a view of the medford:streets layer*

#.  The check boxes are used control layer visibility. Any number of layers can be
    visible at one time. You can turn on and off layers by checking and un-checking,  
    respectively, the check box to the right of a layer name. 
    
    .. figure:: images/getting_started3.png
       :align: center
       :width: 600px
       
       *Styler with multiple Medford layers active*
       
#.  The radio buttons are used to set the layer to be styled. Only a single layer can be
    styled at once. Turn on and off layer editing by checking and un-checking, the radio 
    buttons to the right of a layer name.
    
    .. figure:: images/getting_started4.png
       :align: center
       
       *Check-marking medford:streets for viewing*
    
#.  To style a layer, click the style rule, e.g., RailRoad Border. 

    .. figure:: images/getting_started5.png
       :align: center
       
       *Opening the Style dialog*

#.  The resulting pop-up box provides easy :guilabel:`Basic`, :guilabel:`Label`, and
    :guilabel:`Advanced` styling.  See the :ref:`styler.styling` section for a more details 
    regarding these tabs. 
    
#.  To :guilabel:`Save` or :guilabel:`Cancel` your style rule, select the respective button, 
    on the bottom right corner of the style pop-up box. 
    
    .. figure:: images/getting_started6.png
       :align: center
       
       *Saving or canceling a style rule*
        
    .. warning:: Styler does not yet support vendor options in SLDs.  Saving a Style will overwrite
       any such saved options.

#.  To add or delete a style rule, select the :guilabel:`Add new` or :guilabel:`Delete Selected` 
    buttons on the bottom of the Layer Legend. 

    .. figure:: images/getting_started7.png
       :align: center
       
       *Adding or deleting a style rule*

    .. note:: Only one style rule can be deleted at a time.
    
#.  To review your revised style, return to the GeoServer :guilabel:`Style Editor`.  
  
  .. figure:: images/getting_started8.png
     :width: 600
     :align: center
     
     *Viewing the Styler revised SLD in the GeoServer Style Editor*





