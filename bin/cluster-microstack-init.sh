#!/bin/bash -x
#	./bin/cluster-microstack-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$debug"	|| exit 201					;
test -n "$stack"	|| exit 202					;
#########################################################################
service=snap.microstack.libvirtd                                        ;
sleep=100								;
#########################################################################
targets=" InstanceMaster1 " 						;
#########################################################################
service_wait_targets $service $sleep $stack "$targets"			;
#########################################################################
command=" ls -l /tmp/microstack_init_finished 2> /dev/null "            ;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################
command=" 								\
  microstack add-compute | tail -1                                      \
" 									;
token_worker="								\
  $(									\
    send_wait_targets "$command" $sleep $stack "$targets"		\
  )									\
"									;
#########################################################################
targets=" InstanceWorker1 InstanceWorker2 InstanceWorker3 " 		;
#########################################################################
service_wait_targets $service $sleep $stack "$targets"			;
#########################################################################
command=" ls -l /tmp/microstack_install_finished 2> /dev/null "         ;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################
command=" microstack init --auto --compute --join $token_worker "       ;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################
