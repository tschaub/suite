#!/bin/bash

gs15data="/opt/opengeo/geoserver/data_dir/"
gssave=/tmp/opengeo_data_dir.zip

#
# Unpack any backed up geoserver data
#
if [ -f $gssave ]; then

  if [ ! -d "$gs15data" ]; then
    # We just installed! The directory should be there!
    exit 1
  fi

  # Remove the blank data dir and replace with saved one
  rm -rf "$gs15data"
  unzip -q $gssave -d $gs15data
  find $gs15data -type d -exec chmod 775 {} ';'
  find $gs15data -type f -exec chmod 664 {} ';'
  chgrp -R admin $gs15data 

  # Move the backup zip file aside
  mv $gssave $gssave.$$

fi
