OpenGeo Suite README
====================

These instructions how to build the OpenGeo Suite platform indepenent 
components. It does not include PostGIS. 

Prerequisites
-------------

The following software packages are required to build the suite.

* `Java Development Kit (JDK) <http://www.oracle.com/technetwork/java/javase/downloads/index-jdk5-jsp-142662.html>`_ - 1.5+
* `Apache Maven <http://maven.apache.org/download.html>`_ - 2.2.1+
* `JSTools <https://github.com/whitmo/jstools>`_ - Latest
* `Sphinx <http://sphinx.pocoo.org/>`_ - 1.0+
* `Git <http://git-scm.com/>`_ - Recent

Quickstart
----------

For the imapatient.

.. note::

   If you build GeoTools, GeoServer, or GeoWebCache with maven locally for other   projects you should skip this quickstart and follow the entire set of 
   instructions.

#. Download `settings.xml <https://raw.github.com/opengeo/suite/master/build/settings.xml>`_

#. Clone the repository:: 

     % git clone git://github.com/opengeo/suite.git suite
     % cd suite

#. Initialize submodule dependnecies::

     % git submodule init 
     % git submodule sync
     % git submodule update

#. Do a full build::

     % mvn -s /path/to/settings.xml clean install -Dfull

Build Environment
-----------------

.. note::

   If you don't build GeoTools, GeoServer, or GeoWebCache locally on a regular 
   basis you can skip this section.

The suite builds its own internal versions of many components like GeoTools and 
GeoServer. To keep these builds separate it is recommened that you set up an 
virtual environment for the suite build. 

Tools like `virtualenv <http://pypi.python.org/pypi/virtualenv>`_ and `virtualenvwrapper <http://www.doughellmann.com/projects/virtualenvwrapper/>`_
are useful for creating virtual environments with configuration specific to a   particular project. It is recommened that you set up a  "virtualenv" 
specifically for the suite. In that virtualenv you can configure custom settingsfor maven, etc...

Maven Setup
-----------

Due to the fact that GeoServer depends on GeoTools and GeoWebCache via 
SNAPSHOT versions, Maven must be configured to not download SNAPSHOT versions 
from any online repositories that publish GeoTools and GeoWebCache artifacts.

.. note::

   If you don't build GeoServer, GeoTools, or GeoWebCache locally for other 
   projects then you can skip teh part in ``settings.xml`` about a custom 
   repository.

Set up a custom ``settings.xml`` file::

  <settings>
   <localRepository>[path to custom maven repository]</localRepository>
   <profiles>
     <profile>
      <id>no-snapshots</id>
      <repositories>
       <repository>
        <id>opengeo</id>
        <name>opengeo</name>
        <snapshots>
         <enabled>false</enabled>
         <updatePolicy>never</updatePolicy>
        </snapshots>
        <url>http://repo.opengeo.org/</url>
       </repository>
       <repository>
        <id>osgeo</id>
        <name>Open Source Geospatial Foundation Repository</name>
        <url>http://download.osgeo.org/webdav/geotools/</url>
        <snapshots>
         <enabled>false</enabled>
         <updatePolicy>never</updatePolicy>
        </snapshots>
       </repository>
       <repository>
        <id>org.mapfish</id>
        <name>MapFish Repository</name>
        <url>http://dev.mapfish.org/maven/repository</url>
        <snapshots>
         <enabled>false</enabled>
         <updatePolicy>never</updatePolicy>
        </snapshots>
       </repository>
      </repositories>
     </profile>
    </profiles>
    <activeProfiles>
      <activeProfile>no-snapshots</activeProfile>
    </activeProfiles>
   </settings>
 
This file must be used for maven builds. An easy way to do this is to alias
the ``mvn`` command::

  % alias mvn="mvn -s /path/to/settings.xml"

Repository Setup
----------------

The suite repository contains submodules that pull in external dependencies. 
After cloning the repository you must initialize the submodules::

  % git clone git://github.com/opengeo/suite.git suite
  % cd suite
  % git submodule init
  % git submodule sync
  % git submodule update

Building
--------

If you are building the suite locally for the first time you *must* do a full 
build::

  % mvn clean install -Dfull

The above command will build everything, including all external dependencies.
Dropping the ``-Dfull`` flag will only build the core suite components::

  % mvn clean install

To build a distribution a full build must first be completed. After which the 
following command is used::

  % mvn assembly:attached 

Resulting artifacts will be located in the ``target`` directory. 

The build and assembly commands can also be merged into one::

  % mvn clean install assembly:attached -Dfull

Building GeoServer Externals
----------------------------

As mentioned above the suite pulls in many external components as submodules. 
The ones required to build the OpenGeo Suite GeoServer are located in the 
``geoserver/externals`` directory and include GeoServer itself, GeoTools, and 
GeoWebCache. 

During a suite maven build these externals are only built if the ``-Dfull`` flag
is specified. 

Custom Build Flags
^^^^^^^^^^^^^^^^^^

Each of these externals is built with a separate maven process so 
flags such as -o (offline) are not propagated. To propogate custom flags to the
respective build commands specific properties must be set.

* ``gs.flags`` - GeoServer build flags
* ``gt.flags`` - GeoTools build flags
* ``gwc.flags`` - GeoWebCache build flags

For instance, perhaps we want to enable a GeoServer extension that is typically
not built and distributed with the suite. The following command can be used::

  % mvn clean install -Dfull -Dgs.flags="-P app-schema"

Often the build of one the submodules fails. For projects like GeoTools that 
contain many modules rebuilding all previously built modules is onerous. The 
``-rf`` maven option can be used to restart the build from a particular module::

  % mvn clean install -Dfull -Dgt.flags="-rf modules/library/render"

Offline Builds
^^^^^^^^^^^^^^

Offline builds are useful in projects like the suite and its dependants that 
contain SNAPSHOT dependencies. However as mentioned above because the externals
are built with a separate maven command, the offline switch will not be 
propogated. The ``-Doffline`` flag is used to signal to the respective builds
that offline mode should be used::

  % mvn clean install -Dfull -Doffline






