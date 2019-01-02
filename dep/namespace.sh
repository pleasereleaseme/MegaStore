#!/bin/bash
PATH=$1
ENV=$2

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f k8s-config-build/k8s-config/namespace-$ENV.yaml