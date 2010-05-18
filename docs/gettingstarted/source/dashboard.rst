.. _dashboard:

Dashboard
=========

The OpenGeo Suite comes with a Dashboard.  The OpenGeo Suite Dashboard is a single interface that allows you to access all components of the OpenGeo Suite, including links to common tasks, configuration, and management.  It runs on the host machine as an application, not in a web browser.

(IMAGE)

.. note:: When you first launch the OpenGeo Suite Dashbaord, you will be presented with the GeoServer username and password.  These credentials are used to administer GeoServer.  You can change this information on the :ref:`dashboard.prefs` pane.

(IMAGE)

Starting and Stopping
---------------------

The Dashboard can start and stop the OpenGeo Suite.  Simply click on the Start or Stop button at the bottom right of the Dashboard.  Many links in the Dashboard will be disabled unless the OpenGeo Suite is online.

.. note:: The first time the OpenGeo Suite is started might take a few minutes to initialize the software.  Subsequent starting times will be greatly reduced.

(IMAGES)

You can also start and stop the OpenGeo Suite from the command prompt.  Navigate to the root of your installation directory and run::

   > opengeo-suite start
   > opengeo-suite stop


Quickstart
----------

The Dashboard contains a Quickstart page, which is designed to show a sample workflow for publishing your data and creating your maps.  A more detailed discussion is available here in the :ref:`workflow`.

(IMAGE)


Dashboard Pages
---------------

Contained in the dashboard are brief introductions to each of the components of the OpenGeo Suite, including links to documentation and common tools.

(IMAGE)

.. _dashboard.prefs:

Preferences
-----------

You can configure the OpenGeo Suite through the Preferences page.

.. warning:: You must stop and start the OpenGeo Suite for any changes to take effect.

(IMAGE)

Service Ports
~~~~~~~~~~~~~

The OpenGeo Suite runs a web server on your host machine that responds on a specific port (the default is **8080**).  You can change this by  changing the :guilabel:`Port` value.  Click :guilabel:`Save` when done.  Restart the OpenGeo Suite for the change to take effect.  

GeoServer Data Directory
~~~~~~~~~~~~~~~~~~~~~~~~

GeoServer's data and configuration is stored in what is known as the data directory.  You can point the OpenGeo Suite to a different GeoServer data directory if you'd like (or move the existing data directory to another location) by changing the value of :guilabel:`Data Directory`.  Click :guilabel:`Save` when done.  Restart the OpenGeo Suite for the change to take effect.

GeoServer Administration
~~~~~~~~~~~~~~~~~~~~~~~~

Most GeoServer administrative tasks require authentication.  The default username and password for the GeoServer that is contained in the OpenGeo Suite is ``admin`` / ``geoserver``.  To change these credentials, enter new values in the :guilabel:`Username` and :guilabel:`Password` fields.  You will need to type the password in again in the :guilabel:`Confirm` field.  Click :guilabel:`Save` when done.  Restart the OpenGeo Suite for the change to take effect.