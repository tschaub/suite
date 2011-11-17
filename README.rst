OpenGeo Suite README
====================

These instructions how to build the OpenGeo Suite platform indepenent 
components. It does not include PostGIS. 

Prerequisites
-------------

The following software packages are required to build the suite.

* `Java Development Kit (JDK) 1.5 <http://www.oracle.com/technetwork/java/javase/downloads/index-jdk5-jsp-142662.html>`_
* `Apache Maven 2.2.1+ <>`_
* `JSTools <https://github.com/whitmo/jstools>`_
* `Sphinx <http://sphinx.pocoo.org/>`_
* `Git <http://git-scm.com/>`_

Build Environment
-----------------

The suite builds its own internal versions of many components like GeoTools and 
GeoServer. To keep these builds separate it is recommened that you set up a 
maven repository for the suite separate from your existing local maven 
repository.

.. note::

   Tools like `virtualenv <>` and `virtualenvwrapper <>` are useful for creating
   virtual environments with configuration specific to a particular project. It
   is recommened that you set up a  "virtualenv" specifically for the suite. In
   that virtualenv you can configure the custom maven settings.

Also due to the fact that GeoServer depends on GeoTools and GeoWebCache via 
SNAPSHOT versions, Maven must be configured to not download SNAPSHOT versions 
from any online repositories that publish GeoTools and GeoWebCache artifacts.

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

  alias mvn="mvn -s /path/to/settings.xml"
