#!/bin/bash

. functions

# grab files
get_file http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64-jdk.bin
get_file http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-i586-jdk.bin
get_file http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64-jdk.bin
get_file http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-i586-jdk.bin
get_file 

# clean out old sources
pushd opengeo-jai
ls | grep -v debian | xargs rm -rf
popd

# unpack sources
unzip -o files/jai-1_1_3-lib-linux-amd64-jdk.bin -d opengeo-jai
#checkrc $? "unpacking jai amd64"
unzip -o files/jai_imageio-1_1-lib-linux-amd64-jdk.bin -d opengeo-jai
#checkrc $? "unpacking jai imageio amd64"
unzip -o files/jai-1_1_3-lib-linux-i586-jdk.bin -d opengeo-jai
#checkrc $? "unpacking jai i586"
unzip -o files/jai_imageio-1_1-lib-linux-i586-jdk.bin -d opengeo-jai
#checkrc $? "unpacking jai imageio i586"

# build
#build_deb opengeo-jai
