#!/bin/bash

#set -e
#set -x

if [ "$#" -lt 2 ]
then
    echo "$0 <FROM> <TO> [--no-filter]"
    exit
fi

args=( $* )
for (( i=2; i < ${#args[*]}; i++ )); do
  arg=${args[$i]}
  if [ $arg == "--no-filter" ]; then
    no_filter=$arg
  fi
done

from=$1
to=$2

git log $from..$to | grep "#" | sed 's/^/  > /g'
echo 

submodules=`git submodule status | cut -d ' ' -f 3 | xargs`
for sub in $submodules; do
  if [ ! -z $no_filter ]; then 
    git submodule summary $from $to $sub
  else
    git submodule summary $from $to $sub | egrep "\*|GEOS-|GEOT-|#"
    echo 
  fi
done
