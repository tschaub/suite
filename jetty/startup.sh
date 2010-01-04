#!/bin/bash

PWD=`pwd`

SCRIPT=`readlink -f $0`
cd `dirname $SCRIPT`
 
if [ ! -e "`pwd`/og-jetty.jar" ]; then
  echo "Could not find og-jetty.jar"
  exit -1
fi

_RUNJAVA=""
if [ "$JAVA_HOME" != "" ] && [ -e $JAVA_HOME/bin/java ]; then
  _RUNJAVA=$JAVA_HOME/bin/java
else
  which java > /dev/null
  if [ "$?" == "1" ]; then
    echo "JAVA_HOME is not defined, and java is not on the current PATH"
    exit
  fi
  _RUNJAVA=`which java`
fi

GDD=$GEOSERVER_DATA_DIR
if [ "$GDD" == "" ]; then
  GDD=`pwd`/data_dir
fi

CLASSPATH=og-jetty.jar:jetty-start.jar:lib/ini4j-0.5.1.jar
exec "$_RUNJAVA" -DGEOSERVER_DATA_DIR="$GDD" -Djava.awt.headless=true -DSTOP.PORT=8079 -DSTOP.KEY=opengeo -cp $CLASSPATH org.opengeo.jetty.Start

cd $PWD
