#!/bin/bash -x
#	./bin/cluster-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 100 ;
test -n "$B"	                && export B                 || exit 101 ;
test -n "$branch" && export branch || exit 102                          ;
test -n "$debug" 		&& export debug	            || exit 103	;
test -n "$domain" 		&& export domain	    || exit 104	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 105 ;
test -n "$mode"                 && export mode	            || exit 106	;
test -n "$stack"                && export stack	            || exit 107	;
#########################################################################
file=common-functions.sh						;
path=lib                                 				;
uuid=$( uuidgen )                                                       ;
#########################################################################
path=$uuid/$path                                                        ;
git clone                                                               \
  --single-branch --branch $branch_aws                                  \
  https://$domain/$B                                                    \
  $uuid                                                                 \
                                                                        ;
source ./$path/$file                                                    ;
rm --force --recursive $uuid                                            ;
#########################################################################
export -f send_command							;
export -f send_list_command						;
export -f send_wait_targets						;
export -f service_wait_targets						;
#########################################################################
file=cluster-$mode-init.sh						;
path=bin								;
#########################################################################
./$path/$file                                                           ;
#########################################################################
