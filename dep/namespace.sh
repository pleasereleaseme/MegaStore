#!/bin/bash
PATH=$1
ENV=$2

echo "PATH is $PATH"

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $PATH/namespace-$ENV.yaml