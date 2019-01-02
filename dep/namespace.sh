#!/bin/bash
PATH=$1
ENV=$2

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $PATH/namespace-$ENV.yaml