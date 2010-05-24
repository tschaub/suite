.. _workflow.load:

Step 1: Load Your Data
======================

.. note:: If you'd like to serve data directly from shapefiles, you can skip to the next section, :ref:`workflow.import`.

The first step of any workflow is to load your data into the OpenGeo Suite.  For the purposes of this workflow, we will assume that your initial data is stored as shapefiles, although there are many types of data formats that are compatible with the OpenGeo Suite.

#. Launch the OpenGeo Suite :ref:`dashboard` and Start the OpenGeo Suite, if you have not already done so.

   (IMAGE)

#. Click on the :guilabel:`Load Shapefiles` link.  (THIS LINK MAY CHANGE.)

   (IMAGE)

#. This will load :guilabel:`pgShapeLoader` which will allow you to convert shapefiles to a tables in a PostGIS database.  Next, click on the box that is titled "Shape File."

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

Determining projections
-----------------------

.. note:: For a workaround that eliminates the need to find the shapefile projection, you can import shapefiles directly into GeoServer.  Please skip to the :ref:`workflow.import` section for details.

There are three ways to determine the projection for a shapefile if it is not known.  You can look at read metadata, search the source site, or search `spatialreference.org <http://spatialreference.org>`_.

Read metadata
~~~~~~~~~~~~~

Shapefiles often have a metadata file included with it.  This metadata file can include information about the data contained in the shapefile, including the projection.  Look for an ``.xml`` file or ``.txt`` file among your shapefile collection and open this file in a text editor.  The projection will usually be a numerical code, possibly with a text prefix.  Examples:  "EPSG:4326" "EPSG:26918" "900913"

Search the source site
~~~~~~~~~~~~~~~~~~~~~~

Data download sites usually display information about the shapefiles on the site itself, sometimes on a page called "metadata" or "information about this data".  The projection will usually be a numerical code, possibly with a text prefix.  Examples:  "EPSG:4326" "EPSG:26918" "900913"

Search spatialreference.org
~~~~~~~~~~~~~~~~~~~~~~~~~~~

`spatialreference.org <http://spatialreference.org>`_ is a web site that offers information on projections.  You can use the site's search box to help determine the projection for your shapefile.

   (IMAGE?)

Shapefiles are comprised of multiple files, each with different extensions (``.shp``, ``.shx``, ``.prj`` and others).  Open the file with the ``.prj`` file in a text editor.  This file contains the technical details of the projection.  Copy the first block of text inside quotes and paste it into the search box of spatialreference.org .  Assuming a match, the site will return the likely projection code.  If the first text block fails, try the next block of text inside quotes.  Repeat this process if necessary to obtain the likely projection code.

Workaround
~~~~~~~~~~

If you are still unable to find the projection, you can instead load your shapefiles directly into GeoServer, bypassing PostGIS.  GeoServer may be able to intelligently determine the proper projection.  See the :ref:`workflow.import` section for details.

Viewing/verifying data
----------------------

To verify that your data was loaded properly, you can use :guilabel:`pgAdmin`, a desktop GUI for database management.

#. Launch pgAdmin by clicking the :guilabel:`Manage` link on the Dashboard.

   (IMAGE)

#. Click on the database instance in the (WHAT) column.

   (IMAGE)

#. If you are asked for a password, you can leave it blank.

   (IMAGE)

#. Expand the tree to view :menuselection:`localhost --> Databases -> [username] -> Tables`.  You should see a listing of tables corresponding to the shapefiles that you loaded.

   .. note:: The two tables that don't correpsond to shapefiles are required by PostGIS.  They are automatically created.

   (IMAGE)

For more information about PostGIS and pgAdmin, please see the Styler Documentation. You can access this by clicking the :guilabel:`PostGIS Documentation` link in the :ref:`dashboard`.