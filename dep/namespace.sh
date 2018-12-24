#!/bin/bash
ENVIRONMENT=$1

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f k8sbuild/k8s-config/namespace-$ENVIRONMENT.yaml