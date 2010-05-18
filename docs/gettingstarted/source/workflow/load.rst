.. _workflow.load:

Step 1: Load Your Data
======================

.. note:: If you'd like to skip the loading of shapefiles into PostGIS, and instead serve data directly from shapefiles, you can skip to the next section, :ref:`workflow.import`.

The first step of any workflow is to load your data into the OpenGeo Suite.  For the purposes of this workflow, we will assume that your initial data is stored as shapefiles, although there are many types of data formats that the OpenGeo Suite can load.

#. Launch the OpenGeo Suite Dashboard and Start the OpenGeo Suite, if you have not already done so.

(IMAGE)

#. Click on the :guilabel:`Load Shapefiles` link.  

(IMAGE)

#. This will load the PostGIS Shapefile Loader application, which will allow you to convert shapefiles to a tables in a PostGIS database.  Next, click on the box that is titled "Shape File."

(IMAGE)

#. In the folder dialog that appears, navigate to the location of your first shapefile, then click :guilabel:`Open`.

(IMAGE)

#.  Next, fill out the form:

   .. list-table::
      :widths: 20 80

      * - **Username**
        - postgres
      * - **Password**
        - [blank]
      * - **Server Host**
        - localhost
      * - **Port**
        - 54321
      * - **Database**
        - [your user name on your host operating system]
      * - **SRID**
        - The projection code for your shapefile

   .. note:: If you don't know the projection code (sometimes known as SRID, SRS, CRS, or EPSG code) see the next section on :ref:`workflow.load.projection`.

(IMAGE)

#. When finished, click :guilabel:`Import`.

(IMAGE)

#. Repeat the same process for every shapefile you wish to load.

.. _workflow.load.projection:

Determining projection
----------------------

.. note:: For a workaround that eliminates the need to find the shapefile projection, albeit one that excludes using PostGIS, you can import shapefiles directly into GeoServer.  Please skip to the :ref:`workflow.import` section for details.

There are a few ways to determine the projection for a shapefile.

Look at metadata
~~~~~~~~~~~~~~~~

Shapefiles often have a metadata file included with it.  This metadata file can include information about the data contained in the shapefile, including the projection.  Look for an XML file or TXT file among your shapefile collection and read this file in a text editor.  The projection will usually be a numerical code, possibly with a text prefix.  Examples:  "EPSG:4326" "EPSG:26918" "900913"

Search the source site
~~~~~~~~~~~~~~~~~~~~~~

Data download sites include information about the shapefiles on the site itself.  Search the location where you downloaded the shapefile for the projection.  The projection will usually be a numerical code, possibly with a text prefix.  Examples:  "EPSG:4326" "EPSG:26918" "900913"

Search spatialreference.org
~~~~~~~~~~~~~~~~~~~~~~~~~~~

`spatialreference.org <http://spatialreference.org>`_ is a web site that offers information on projections.  You can use the site's search box to help determine the projection for your shapefile.

(IMAGE?)

Shapefiles are comprised of multiple files, each with different extensions (.shp,.shx,.prj and others).  Open the .prj file in a text editor.  This file contains the technical details of the projection.  Copy the first block of text inside quotes and paste it into the search box of spatialreference.org .  Assuming a match, the site will return the likely projection code.  If the first text block fails, try the next block of text inside quotes.  Repeat this process to narrow down, if not pinpoint exactly, the projection code.

Workaround
~~~~~~~~~~

If you are still unable to find the projection code, you can instead load your shapefiles directly into GeoServer, bypassing PostGIS.  GeoServer may be able to intelligently determine the proper projection.  See the :ref:`workflow.import` section for details.
