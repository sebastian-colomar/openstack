#!/bin/bash -x
#	./bin/aws-init.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set +x && test "$debug" = true && set -x				;
#########################################################################
test -n "$A"	                && export A                 || exit 401 ;
test -n "$branch" && export branch || exit 402                          ;
test -n "$debug" 		&& export debug	            || exit 403	;
test -n "$domain" 		&& export domain	    || exit 404	;
test -n "$HostedZoneName"	&& export HostedZoneName    || exit 405 ;
test -n "$Identifier"		&& export Identifier        || exit 406 ;
test -n "$RecordSetName1"	&& export RecordSetName1    || exit 407 ;
test -n "$stack"                && export stack	            || exit 408	;
test -n "$template"		&& export template    	    || exit 409 ;
test -n "$TypeMaster"		&& export TypeMaster 	    || exit 410 ;
test -n "$TypeWorker"		&& export TypeWorker 	    || exit 411 ;
#########################################################################
BranchAWS=$branch                                                       ;
caps=CAPABILITY_IAM							;
NodeInstallUrlPath=https://$domain/$A					;
#########################################################################
path=etc/aws								;
#########################################################################
aws cloudformation create-stack 					\
  --capabilities 							\
    $caps 								\
  --parameters 								\
    ParameterKey=BranchAWS,ParameterValue=$BranchAWS                    \
    ParameterKey=HostedZoneName,ParameterValue=$HostedZoneName		\
    ParameterKey=InstanceMasterInstanceType,ParameterValue=$TypeMaster	\
    ParameterKey=InstanceWorkerInstanceType,ParameterValue=$TypeWorker  \
    ParameterKey=Identifier,ParameterValue=$Identifier			\
    ParameterKey=NodeInstallUrlPath,ParameterValue=$NodeInstallUrlPath	\
    ParameterKey=RecordSetName1,ParameterValue=$RecordSetName1		\
  --stack-name 								\
    $stack 								\
  --template-body                                                       \
    file://$path/$template                                              \
  --output 								\
    text 								\
									;
#########################################################################
while true 								;
do 									\
  aws cloudformation describe-stacks 					\
    --query 								\
      "Stacks[].StackStatus" 						\
    --output 								\
      text 								\
    --stack-name 							\
      $stack 								\
  | 									\
  grep CREATE_COMPLETE && break 					;
  sleep 100 								;
done									;
#########################################################################
