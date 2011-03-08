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

if [ -z "$2" ]; then
  echo "Usage: $0 AMI_ID [-n IMAGE_NAME] [-t 'ebs'|'s3'] [ -a 'i386'|'x86_64']"
  exit 1
fi

# ensure the ec2 api tools are properly setup
check_ec2_tools

# parse the command line args
args=( $* )
for (( i = 2; i < ${#args[*]}; i++ )); do
  if [ "${args[$i]}" == "-t" ]; then
    IMAGE_TYPE=${args[(( i+1 ))]}
  fi
  if [ "${args[$i]}" == "-n" ]; then
    IMAGE_NAME=${args[(( i+1 ))]}
  fi
  if [ "${args[$i]}" == "-a" ]; then
    IMAGE_ARCH=${args[(( i+1 ))]}
  fi
done

if [ -z $IMAGE_TYPE ]; then
  IMAGE_TYPE="ebs"
fi
if [ -z $IMAGE_ARCH ]; then
  IMAGE_ARCH="i386"
fi

AMI_ID=$1
IMAGE_NAME=$2
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
scp $SSH_OPTS prep_ubuntu_image.sh functions ubuntu@$HOST:/home/ubuntu
check_rc $? "updload prep script"

ssh $SSH_OPTS ubuntu@$HOST 'cd /home/ubuntu && ./prep_ubuntu_image.sh'
check_rc $? "remote prepare"

if [ $IMAGE_TYPE == "ebs" ]; then
  ec2-create-image -n $IMAGE_NAME $INSTANCE_ID
else
  scp $SSH_OPTS bundle_s3_image.sh $EC2_PRIVATE_KEY $EC2_CERT ubuntu@$HOST:/home/ubuntu
  check_rc $? "upload private key and certificate"

  ssh $SSH_OPTS ubuntu@$HOST 'cd /home/ubuntu && ./bundle_s3_image.sh $IMAGE_NAME'
  check_rc $? "remote bundle image"
    
fi
