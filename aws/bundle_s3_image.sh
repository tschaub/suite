#!/bin/bash

set -x

. functions
. s3.properties

if [ -z $2 ]; then
  echo "Usage: $0 NAME ARCH [-p PRODUCT_ID] [--skip-bundle] [--skip-upload] [--skip-register] [--skip-product-code ]"
  exit 1
fi
args=( $* )
for (( i=2; i < ${#args[*]}; i++ )); do
  if [ ${args[$i]} == "-p" ]; then
    PRODUCT_ID=${args[(( i+1 ))]}
  fi
  if [ ${args[$i]} == "--skip-bundle" ]; then
    SKIP_BUNDLE="yes"
  fi
  if [ ${args[$i]} == "--skip-upload" ]; then
    SKIP_UPLOAD="yes"
  fi
  if [ ${args[$i]} == "--skip-register" ]; then
    SKIP_REGISTER="yes"
  fi
  if [ ${args[$i]} == "--skip-product-code" ]; then
    SKIP_PRODUCT_CODE="yes"
  fi
done

IMAGE_NAME=$1
IMAGE_ARCH=$2
export EC2_PRIVATE_KEY=`ls /tmp/pk-*`
export EC2_CERT=`ls /tmp/cert-*`

# install the ec2-api/ami-tools and s3cmd
sudo bash -c "echo 'deb http://us.archive.ubuntu.com/ubuntu/ lucid multiverse' >> /etc/apt/sources.list"
sudo apt-get update
sudo apt-get -y install ec2-api-tools ec2-ami-tools s3cmd
check_rc $? "apt-get install ec2 api/ami + s3cmd tools"

# back for the 64 bit ami we are using for a base, it includes a grub menu.lst
# file that contains mount entries that use wierd labels, modify it
# use block-device-mapping to fix
if [ -e /boot/grub/menu.lst ]; then
  sudo sed -i 's/root=LABEL=uec-rootfs/root=\/dev\/sda1/g' /boot/grub/menu.lst 
fi

IMAGE_MANIFEST=/tmp/image.manifest.xml

if [ -z $SKIP_BUNDLE ]; then
  # bundle the image
  sudo ec2-bundle-vol -c $EC2_CERT -k $EC2_PRIVATE_KEY -u $S3_USER -r $IMAGE_ARCH
  check_rc $? "ec2-bundle-vol"
fi

if [ ! -e  $IMAGE_MANIFEST ]; then
  echo "No such file $IMAGE_MANIFEST. Exiting."
  exit 1
fi

S3_BUCKET=$S3_BUCKET_ROOT/$IMAGE_NAME
S3_BUCKET_WEST=$S3_BUCKET_ROOT_WEST/$IMAGE_NAME
S3_BUCKET_EU=$S3_BUCKET_ROOT_EU/$IMAGE_NAME
S3CMD_CONFIG=/tmp/s3cfg
S3CMD_CONFIG_WEST=/tmp/s3cfg.us-west
S3CMD_CONFIG_EU=/tmp/s3cfg.us-west

s3cmd -c $S3CMD_CONFIG ls s3://$S3_BUCKET_ROOT 
check_rc $? "listing contents of $S3_BUCKET_ROOT"

# figure out if the directory already exists, and delete it if necessary

# clear_s3_bucket <S3CMD_CONFIG> <BUCKET_ROOT>
function clear_s3_bucket() {
  s3cmd -c $1 ls s3://$2 | grep $IMAGE_NAME
  if [ $? -eq 0 ]; then
    s3cmd -c $1 -r del s3://$2
  fi
}
#s3cmd -c $S3CMD_CONFIG ls s3://$S3_BUCKET_ROOT | grep $IMAGE_NAME
#if [ $? -eq 0 ]; then
#  s3cmd -c $S3CMD_CONFIG -r del s3://$S3_BUCKET
#fi
clear_s3_bucket $S3CMD_CONFIG $S3_BUCKET_ROOT
clear_s3_bucket $S3CMD_CONFIG_EU $S3_BUCKET_ROOT_EU

if [ -z $SKIP_UPLOAD ]; then
  # upload the bundle
  ec2-upload-bundle --retry -b $S3_BUCKET -m $IMAGE_MANIFEST -a $S3_ACCESS_KEY -s $S3_SECRET_KEY
  check_rc $? "ec2-upload-bundle"

  # migrate to us west
  #ec2-migrate-bundle --retry -a $S3_ACCESS_KEY -s $S3_SECRET_KEY -b $S3_BUCKET -m `basename $IMAGE_MANIFEST` -d $S3_BUCKET_WEST --location us-west-1
  #check_rc $? "ec2-migrate-bundle $S3_BUCKET to us-west-1"

  # migrate to eu west
  ec2-migrate-bundle --retry -a $S3_ACCESS_KEY -s $S3_SECRET_KEY -b $S3_BUCKET -m `basename $IMAGE_MANIFEST` -d $S3_BUCKET_EU --location eu-west-1
  check_rc $? "ec2-migrate-bundle $S3_BUCKET to us-west-1"
fi

# register_ami <S3_BUCKET> <LOCATION>
function register_ami() {
    #IMAGE_ID=$( ec2-register $S3_BUCKET/image.manifest.xml -n $IMAGE_NAME -a $IMAGE_ARCH | cut -f 2 )
    IMAGE_ID=$( ec2-register --region $2 $1/image.manifest.xml -n $IMAGE_NAME -a $IMAGE_ARCH | cut -f 2 )
    check_rc $? "ec2-register"
  
    if [ ! -z $PRODUCT_ID ] && [ -z $SKIP_PRODUCT_CODE ]; then
      # link the image to the product id
      ec2-modify-image-attribute $IMAGE_ID -p $PRODUCT_ID
      check_rc $? "linking image $IMAGE_ID to product $PRODUCT_ID"
    
      # make the image public
      ec2-modify-image-attribute $IMAGE_ID -l -a all
      check_rc $? "making image $IMAGE_ID public"
  
      # tag the image
      # DISABLING for now, ec2-create-tags not available
      #ec2-create-tags $IMAGE_ID --tag geoserver --tag postgis --tag opengeo --tag openlayers --tag gis --tag geospatial --tag "opengeo suite"
      #check_rc $? "create image tags for $IMAGE_ID"
    fi
}

if [ -z $SKIP_REGISTER ]; then
    # register the ami
    register_ami $S3_BUCKET us-east-1
    #register_ami $S3_BUCKET_WEST us-west-1
    register_ami $S3_BUCKET_EU eu-west-1
fi
