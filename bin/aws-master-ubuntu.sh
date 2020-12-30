#!/bin/sh -x
#	./bin/aws-master-ubuntu.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x 	&& test "$debug" = true	&& set -x				;
#########################################################################
touch /tmp/microstack_install
snap install microstack --beta --devmode                                ;
while true								;
do 									\
  service snap.microstack.libvirtd status | grep running -q && break    ;
  sleep 10								;
done									;
touch /tmp/microstack_install_finished
touch /tmp/microstack_init
microstack init --auto --control                                        ;
#########################################################################
