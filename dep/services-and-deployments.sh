#!/bin/bash
ENVIRONMENT=$1

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f _k8s/k8s-config/message-queue-service.yaml --namespace=$ENVIRONMENT

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f _k8s/k8s-config/megastore-web-service.yaml --namespace=$ENVIRONMENT

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f _k8s/k8s-config/message-queue-deployment.yaml --namespace=$ENVIRONMENT

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f _k8s/k8s-config/megastore-web-deployment.yaml --namespace=$ENVIRONMENT

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f _k8s/k8s-config/megastore-savesalehandler-deployment.yaml --namespace=$ENVIRONMENT