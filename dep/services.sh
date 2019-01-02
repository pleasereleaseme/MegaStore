#!/bin/bash
CONFIGPATH=$1
ENV=$2

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/message-queue-service.yaml --namespace=$ENV

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/megastore-web-service.yaml --namespace=$ENV