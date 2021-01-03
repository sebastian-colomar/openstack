#!/bin/bash -x
#	./bin/init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 100 ;
test -n "$B"	                && export B                 || exit 100 ;
test -n "$branch" && export branch || exit 102                          ;
test -n "$debug" 		&& export debug	            || exit 100	;
test -n "$domain" 		&& export domain	    || exit 100	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 100 ;
test -n "$Identifier"		&& export Identifier        || exit 100 ;
test -n "$mode"                 && export mode	            || exit 100	;
test -n "$RecordSetName1"	&& export RecordSetName1    || exit 100 ;
test -n "$stack"                && export stack	            || exit 100	;
test -n "$template"		&& export template    	    || exit 100 ;
test -n "$TypeMaster"		&& export TypeMaster 	    || exit 100 ;
test -n "$TypeWorker"		&& export TypeWorker 	    || exit 100 ;
#########################################################################
path=bin								;
#########################################################################
file=aws-init.sh                                               		;
#########################################################################
./$path/$file                                                           ;
#########################################################################
file=cluster-init.sh							;
#########################################################################
./$path/$file                                                           ;
#########################################################################
