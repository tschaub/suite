Installing the OpenGeo Suite
============================

This document describes how to install the OpenGeo Suite on Linux. More detailed operating instructions are available once the software is installed.


Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* **Operating System**: Ubuntu 10.04 and 10.10, CentOS 5
* **Memory**: 512MB minimum (1GB recommended)
* **Disk space**: 500MB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported (Internet Explorer 6+, Firefox 3+, Chrome 2+, Safari 3+)
* **Permissions**: Super user privileges are required for installation

Installation
------------

Packages for the OpenGeo Suite are currently available in both :ref:`rpm <rpm>` and :ref:`apt <apt>` (debian) format. 

.. note:: The commands contained in the following installation instructions must be run as a user with root privileges. 

.. _rpm:

RPM Installation
^^^^^^^^^^^^^^^^

.. warning:: The rpm packages are only available for CentOS 5 and above.

#. Begin by adding the OpenGeo Yum repository:

   .. parsed-literal::

      cd /etc/yum.repos.d
      wget http://yum.opengeo.org/centos/5/i386/OpenGeo.repo

   .. note:: Replace ``i386`` with ``x86_64`` if installing on a 64 bit system.

#. Search for packages:

   .. parsed-literal::

      yum search opengeo

   .. note:: If the search command does not return any results there was a problem adding the yum repository. Examine the output of yum for any errors or warnings.

#. Install the opengeo-suite package:

   .. parsed-literal::

      yum install opengeo-suite

.. _apt:

APT Installation
^^^^^^^^^^^^^^^^

.. warning:: The apt packages are only available for Ubuntu 10.04 and above.

#. Begin by importing the OpenGeo GPG key:

   .. parsed-literal::

      wget -qO- http://apt.opengeo.org/gpg.key | apt-key add -

#. Add the OpenGeo APT repository:

   .. parsed-literal::

      echo "deb http://apt.opengeo.org/ubuntu lucid main" >> /etc/apt/sources.list
      
#. Update:

   .. parsed-literal::

      apt-get update

#. Search for packages:

   .. parsed-literal::

      apt-cache search opengeo

   .. note:: If the search command does not return any results there was a problem adding the apt repository. Examine the output of apt for any errors or warnings.

#. Install the opengeo-suite package:

   .. parsed-literal::

      apt-get install opengeo-suite

For More Information
--------------------

Please visit http://opengeo.org or see the documentation included with this software.
