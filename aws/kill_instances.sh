#!/bin/bash

set -x

. functions

ACC=$1
if [ -z $ACC ]; then
  ACC=$ACCOUNT
fi

if [ -z "$ACC" ]; then
  echo "No account specified"
  exit 1
fi

init_ec2_env $ACC

# go through each running instance
for id in `ec2-describe-instances | grep "^INSTANCE" | cut -f 2` ;do
  status=`ec2_instance_status $id`
  if [ "$status" == "running" ]; then
    # check for a tag
    ec2-describe-instances  | grep "^TAG" | grep "$id" | grep "persist"
    if [ $? != 0 ]; then
      echo "killing instance $id in account $ACC"
      ec2-terminate-instances $id
    fi
  fi
done
