#!/bin/bash

. functions

if [ -z $2 ]; then
  echo "Usage: $0 NAME ARCH [--skip-bundle] [--skip-upload] [--skip-register]"
  exit 1
fi
args=( $* )
for (( i=2; i < ${#args[*]}; i++ )); do
  if [ ${args[$i]} == "--skip-bundle" ]; then
    SKIP_BUNDLE="yes"
  fi
  if [ ${args[$i]} == "--skip-upload" ]; then
    SKIP_UPLOAD="yes"
  fi
  if [ ${args[$i]} == "--skip-register" ]; then
    SKIP_REGISTER="yes"
  fi
done

IMAGE_NAME=$1
IMAGE_ARCH=$2
export EC2_PRIVATE_KEY=`ls ~/pk-*`
export EC2_CERT=`ls ~/cert-*`

# install the ec2-api/ami-tools 
sudo bash -c "echo 'deb http://us.archive.ubuntu.com/ubuntu/ lucid multiverse' >> /etc/apt/sources.list"
sudo apt-get update
sudo apt-get -y install ec2-api-tools ec2-ami-tools
check_rc $? "apt-get install ec2 api/ami tools"

if [ -z $SKIP_BUNDLE ]; then
  # bundle the image
  sudo ec2-bundle-vol -u 372029072695 -r $IMAGE_ARCH
  check_rc $? "ec2-bundle-vol"
fi

IMAGE_MANIFEST=/tmp/image.manifest.xml
if [ ! -e  $IMAGE_MANIFEST ]; then
  echo "No such file $IMAGE_MANIFEST. Exiting."
  exit 1
fi

S3_BUCKET=s3.suite.opengeo.org/$IMAGE_NAME

if [ -z $SKIP_UPLOAD ]; then
  # upload the bundle
  ec2-upload-bundle -b $S3_BUCKET -m $IMAGE_MANIFEST -a AKIAIEIFXZRDU4AY5B3Q -s LbEM4l6xxqHiJUY6Kb6eHyvl3Ryn3ItefAz02mnd
  check_rc $? "ec2-upload-bundle"
fi

if [ -z $SKIP_REGISTER ]; then
  # register the ami
  ec2-register $S3_BUCKET/image.manifest.xml -n $IMAGE_NAME
  check_rc $? "ec2-register"
fi
