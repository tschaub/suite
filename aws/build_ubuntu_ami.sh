#!/bin/bash

. functions

SUITE_KEYPAIR=~/.ec2/suite.pem

# check_ec2_tools
function check_ec2_tools() {
  ec2-version
  check_rc $? "ec2-api-tools not avaialble on PATH, ec2-version"

  if [ -z $EC2_HOME ]; then
     echo "EC2_HOME environment variable not set. Exiting."
     exit 1
  fi
  if [ -z $EC2_PRIVATE_KEY ]; then
     echo "EC2_PRIMARY_KEY environment variable not set. Exiting."
     exit 1
  fi
  if [ -z $EC2_CERT ]; then
     echo "EC2_CERT environment variable not set. Exiting."
     exit 1
  fi
  if [ ! -e $SUITE_KEYPAIR ]; then
     echo "suite keypair: ~/.ec2/suite.pem not found. Exiting."
     exit 1
  fi
}

# poll_instance <client_token> [<max_iterations>]
function poll_instance() {
  local client_token=$1
  local max_iter=$2
  local stat=""
  local i=0  

  if [ -z $max_iter ]; then
    max_iter=50
  fi

  while [ "$stat" != "running" ]; do
    if [ $i -lt $max_iter ]; then
       (( i++ ))
    else
       return 1
    fi
    sleep 5
    
    stat=`ec2-describe-instances -F client-token=$client_token | grep "^INSTANCE" | cut -f 6`   
    log "status of ami $client_token is $stat"
  done

  return 0
}

if [ -z "$1" ]; then
  echo "Usage: $0 <AMI_ID>"
  exit 1
fi

check_ec2_tools

AMI_ID=$1
CLIENT_TOKEN=`uuidgen`

log "Starting instance from ami $AMI_ID with client token $CLIENT_TOKEN"
ec2-run-instances -k suite $AMI_ID --client-token $CLIENT_TOKEN 
check_rc $? "ec2-run-instances"

log "Polling instance"
poll_instance $CLIENT_TOKEN
check_rc $? "poll_instance"

HOST=`ec2-describe-instances -F client-token=$TOKEN | grep "^INSTANCE" | cut -f 4`
log "instance available at $HOST"

INSTANCE_ID=`ec2-describe-instances -F client-token=$TOKEN | grep "^INSTANCE" | cut -f 2`
SSH_OPTS="-i $SUITE_KEYPAIR -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
scp $SSH_OPTS prepare_ubuntu_image.sh functions ubuntu@$HOST:/home/ubuntu
ssh $SSH_OPTS ubuntu@$HOST 'cd /home/ubuntu && ./prepare_ubuntu_image.sh'

ec2-create-image 
