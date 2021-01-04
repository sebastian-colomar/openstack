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
sleep=300								;
#########################################################################
targets=" InstanceMaster1 " 						;
#########################################################################
command=" ls -l /tmp/microstack_init_finished 2> /dev/null "            ;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################
sleep=10								;
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
command=" ls -l /tmp/microstack_install_finished 2> /dev/null "         ;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################
command=" microstack init --auto --compute --join $token_worker "       ;
send_list_targets "$command" $sleep $stack "$targets"			;
#########################################################################
targets=" InstanceMaster1 " 						;
#########################################################################
command=" snap get microstack config.credentials.keystone-password "    ;
send_wait_targets "$command" $sleep $stack "$targets"			;
#########################################################################

