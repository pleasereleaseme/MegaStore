#!/bin/bash

echo "PATH is $K8SCONFIGPATH"
echo "ENV is $ENV"

# service
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/message-queue-service.yaml --namespace=$ENV

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/message-queue-deployment.yaml --namespace=$ENV