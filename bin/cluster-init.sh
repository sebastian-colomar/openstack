#!/bin/bash -x
#	./bin/cluster-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 301 ;
test -n "$B"	                && export B                 || exit 302 ;
test -n "$branch" && export branch || exit 303                          ;
test -n "$debug" 		&& export debug	            || exit 304	;
test -n "$domain" 		&& export domain	    || exit 305	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 306 ;
test -n "$mode"                 && export mode	            || exit 307	;
test -n "$stack"                && export stack	            || exit 308	;
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
export -f send_list_targets						;
export -f send_wait_targets						;
#########################################################################
file=cluster-$mode-init.sh						;
path=bin								;
#########################################################################
./$path/$file                                                           ;
#########################################################################
