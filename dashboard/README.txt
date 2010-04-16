OpenGeo Dashboard
=================

This doc assumes you have downloaded the Dashboard source.

Running the Dashboard
---------------------

Some of the dashboard can be viewed in a regular browser.  You cannot access
Suite applications or start/stop the Suite this way, but it can be useful for
previewing layout changes.  To load the dashboard in a browser, open the 
index.html file found in the OpenGeo\ Dashboard/Resources directory.

The dashboard can be launched by the Titanium Developer application.  Download
Titanium Developer from the Appcelerator site (http://www.appcelerator.com/).
After starting up Titanium Developer, import the OpenGeo Dashboard by clicking
the "Import Project" button and browsing to the OpenGeo\ Dashboard directory.

From the "Test & Package" panel in Titanium Developer, you can launch the 
Dashboard application.


Packaging the Dashboard
-----------------------

The dashboard can be packaged for your operating system by using Titanium
Developer.  Appcelerator also allows for packaging in the "cloud."  This is 
available from the "Package" tab on the "Test & Package" panel in Titanium
Developer.

You can also use the cloud packaging services by running the cloud.py script
included in the dashboard source.  This script requires at least Python 2.6.

See the head of the cloud.py script for usage (or run `python cloud.py -h`).

An example command to build and download packages for Mac OSX, Windows, and 
Linux follows:

    $ python cloud.py -u user@example.com -p userpass OpenGeo\ Dashboard

The result is three packages for the dashboard application downloaded to the current directory (or other if specified).
