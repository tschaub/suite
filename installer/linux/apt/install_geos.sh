#!/bin/bash

. functions

check_root
remove_deb libgeos-dev libgeos-c1 libgeos-3.3.1
install_deb geos libgeos-3.3.1 libgeos-c1 libgeos-dev
checkrc $? "installing geos libs"
