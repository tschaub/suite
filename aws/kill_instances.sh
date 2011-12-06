#!/bin/bash

set -x

. functions

init_ec2_env $ACCOUNT

# go through each running instance
for id in `ec2-describe-instances | grep "^INSTANCE" | cut -f 2` ;do
  status=`ec2_instance_status $id`
  if [ "$status" == "running" ]; then
    # check for a tag
    ec2-describe-instances  | grep "^TAG" | grep "$id" | grep "persist"
    if [ $? != 0 ]; then
      echo "killing instance $id"
      ec2-terminate-instances $id
    fi
  fi
done
