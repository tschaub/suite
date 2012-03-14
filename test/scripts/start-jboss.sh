#!/bin/bash

PIDFILE=/home/web/jboss.pid

if [ -e $PIDFILE ]; then
  echo "pid file $PIDFILE exists, exiting"
  exit 1
fi

pushd `dirname $0` > /dev/null
nohup ./run.sh &> log & 
echo "$!" > $PIDFILE

popd > /dev/null
