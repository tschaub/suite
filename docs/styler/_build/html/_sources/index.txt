.. _styler:

=======
Styler
=======

.. note:: the following needs to be edited. 

Styler is under development by OpenGeo. See the current demo or install the GeoExt Styler plugin for GeoServer. The latest develpment version is available from SVN.

Styler's goal is to democratize cartography – making it easy for anyone to make a map look the way they want it to. This could be as simple as tweaking some colors to match the aesthetics of their website. Or it could mean composing a new map from many different sources with a design that emphasizes the point a user is making with her data. For example, a user could combine data about air quality with data about asthma rates to create a map about public health outcomes near highways.

Our goal is to improve the usability of the styling components of general GIS applications and optimize the experience for web mapping. This means Styler will be a completely web-based application built completely with Javascript, leveraging the OpenLayers and GeoExt libraries, so as to work in any browser. It also leads to a different design focus, optimizing the user experience around setting zoom levels for web map exploration, instead of the traditional GIS emphasis on a single zoom level for printed maps. Styles will also all be open and able to be remixed, so that a user can take someone else's map as a base and change it to suit their purposes, rather than having to start from scratch.

Styler is built on open standards, using the Styled Layer Descriptor (SLD) XML language at the center. It is rendered with the Web Map Service (WMS) standard, which has extensions to render remote SLDs, and uses REST calls to persist styles to servers. It is built with GeoServer as an initial target, but the emphasis on open standards and flexible design should make it adaptable to any WMS server.

The initial release is a standalone application to edit the default styles in GeoServer, but future versions will simply be a set of components that could be used in any GeoExt applications. When that happens the core Styler code base should live in GeoExt, with extensions to talk to various servers (GeoServer, MapFish/Pylons, etc).

Contents
--------

.. toctree::

    getting-started
    styling
    
    glossary
    license


