Installing the OpenGeo Suite for Linux
======================================

This document describes how to install the OpenGeo Suite for Linux.


Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* Operating System: Ubuntu 10.04 and 10.10, CentOS 5
* Memory: 512MB minimum (1GB recommended)
* Disk space: 500MB minimum (plus extra space for any loaded data)
* Browser: Any modern web browser is supported (Internet Explorer 6+, Firefox 3+, Chrome 2+, Safari 3+)
* Permissions: Super user privileges are required for installation

Installation
------------

Packages for the OpenGeo Suite are currently available in both :ref:`RPM <rpm>` and :ref:`APT <apt>` (Debian) format. 

.. note:: The commands contained in the following installation instructions must be run as a user with root privileges, or prefixed with ``sudo``. 

.. _RPM:

RPM Installation
~~~~~~~~~~~~~~~~

.. warning:: The RPM packages are only available for CentOS 5 and above.

#. Begin by adding the OpenGeo Yum repository.

   For 32 bit systems:

   .. code-block:: bash

      cd /etc/yum.repos.d
      wget http://yum.opengeo.org/centos/5/i386/OpenGeo.repo

   For 64 bit systems:

   .. code-block:: bash

      cd /etc/yum.repos.d
      wget http://yum.opengeo.org/centos/5/x86_64/OpenGeo.repo

#. Search for packages:

   .. code-block:: bash

      yum search opengeo

   .. note:: If the search command does not return any results, the repository was not added properly. Examine the output of the ``yum`` command for any errors or warnings.

#. Install the OpenGeo Suite package (opengeo-suite):

   .. code-block:: bash

      yum install opengeo-suite

#. You can launch the OpenGeo Suite Dashboard (and verify the installation was successful) by navigating to the following URL::

      http://localhost:8080/dashboard/
 

.. _APT:

APT Installation
~~~~~~~~~~~~~~~~

.. warning:: The APT packages are only available for Ubuntu 10.04 and above.

#. Begin by importing the OpenGeo GPG key:

   .. code-block:: bash

      wget -qO- http://apt.opengeo.org/gpg.key | apt-key add -

#. Add the OpenGeo APT repository:

   .. code-block:: bash

      echo "deb http://apt.opengeo.org/ubuntu lucid main" >> /etc/apt/sources.list
      
#. Update APT:

   .. code-block:: bash

      apt-get update

#. Search for packages:

   .. code-block:: bash

      apt-cache search opengeo

   .. note:: If the search command does not return any results, the repository was not added properly. Examine the output of the ``apt`` commands for any errors or warnings.

#. Install the OpenGeo Suite package (opengeo-suite):

   .. code-block:: bash

      apt-get install opengeo-suite

#. You can launch the OpenGeo Suite Dashboard (and verify the installation was successful) by navigating to the following URL::

      http://localhost:8080/dashboard/


For More Information
--------------------

Please visit http://opengeo.org/ or see the documentation included with this software.
