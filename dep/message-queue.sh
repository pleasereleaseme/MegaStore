#!/bin/bash

echo "K8SCONFIGPATH is $K8SCONFIGPATH"
echo "RELEASE_ENVIRONMENTNAME is $RELEASE_ENVIRONMENTNAME"

# service
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/message-queue-service.yaml --namespace=$RELEASE_ENVIRONMENTNAME

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/message-queue-deployment.yaml --namespace=$RELEASE_ENVIRONMENTNAME