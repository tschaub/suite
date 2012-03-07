#!/bin/bash

function poll_pid {
  echo -n "polling pid $1 "
  n=10
  if [ "$2" != "" ]; then
    n=$2
  fi
  for (( i = 0 ; i < $n; i++ ))
  do
    if [ ! -d /proc/$1 ]; then
      break
    fi
    echo -n "."
    sleep 2
  done
  echo 
}

PIDFILE=/home/web/jboss.pid
if [ ! -e $PIDFILE ]; then
  echo "pid file $PIDFILE does not exist, exiting"
  exit 1
fi

pushd `dirname $0` > /dev/null
PID=`cat $PIDFILE`

echo "attemping normal shutdown"
./shutdown.sh -S

poll_pid $PID 100

if [ -e /proc/$PID ]; then
  echo "Normal shutdown failed, killing process $PID manually"
  kill -9 $PID
fi

if [ -e /proc/$PID ]; then
  echo "Unable to kill process $PID"
  exit 1
fi

rm $PIDFILE
exit 0

popd > /dev/null
