#!/bin/bash
ENVIRONMENT=$1

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f _k8s/k8s-config/namespace-$ENVIRONMENT.yaml