#!/bin/bash
PATH=$1
ENV=$2

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $PATH/message-queue-service.yaml --namespace=$ENV

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $PATH/megastore-web-service.yaml --namespace=$ENV