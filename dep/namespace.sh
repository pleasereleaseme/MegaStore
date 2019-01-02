#!/bin/bash
CONFIGPATH=$1
ENV=$2

echo "PATH is $CONFIGPATH"

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/namespace-$ENV.yaml