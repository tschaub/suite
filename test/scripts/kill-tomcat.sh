#!/bin/bash

function poll_pid {
  echo -n "polling pid $1 "
  for (( i = 0 ; i < 10; i++ ))
  do
    if [ ! -d /proc/$1 ]; then
      break
    fi
    echo -n "."
    sleep 2
  done
  echo 
}

function return {
  popd > /dev/null
  exit $1
}

pushd `dirname $0` > /dev/null

PIDFILE=`grep CATALINA_PID setclasspath.sh | sed 's/CATALINA_PID=//g'`
if [ ! -e $PIDFILE ]; then
  echo "pid file $PIDFILE does not exist, exiting"
  return 1
fi

PID=`cat $PIDFILE`
ps -p $PID
if [ ! -d /proc/$PID ]; then
  echo "process $PID not found, removing pid file $PID_FILE"
  rm $PIDFILE
  return 0
fi

echo "attempting normal shutdown"
./shutdown.sh

echo "waiting for process $PID to die"
poll_pid $PID

if [ ! -d /proc/$PID ]; then
  echo "shutdown succeeded"
  if [ -e $PIDFILE ]; then
    rm $PIDFILE
  fi
  return 0
else
  echo "shutdown failed, killing process $PID manually"
  kill $PID

  poll_pid $PID
  if [ ! -d /proc/$PID ]; then
    echo "process $PID did not die, trying kill -9"
    kill -9 $PID
    poll_pid $PID
  fi

  if [ ! -d /proc/$PID ]; then
    rm $PIDFILE
    echo "process $PID terminated"
    return 0
  else
    echo "could not kill process $PID, please kill manually and remove $PIDFILE"
    return 1
  fi
fi

