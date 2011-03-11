#!/bin/bash

if [ -z $2 ]; then
  echo "Usage: $0 AMI_ID <i386|x86_64>"
  exit 1
fi

AMI_ID=$1
IMAGE_ARCH=$2
IMAGE_SIZE="m1.small"
if [ $IMAGE_ARCH == "x86_64" ]; then
  IMAGE_SIZE="m1.large"
fi

# initialize ec2 api stuff
pushd $HOME/.ec2/aws-suite-dev > /dev/null
. activate
popd > /dev/null

# get the ami version
. functions
ver=`get_ami_version $REPO_PATH`

# build it
./build_ubuntu_ami.sh $AMI_ID suite-$ver-$IMAGE_ARCH-`date +"%Y%m%d"` -t ebs -s $IMAGE_SIZE
