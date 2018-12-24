#!/bin/bash
TAG=$1
ENVIRONMENT=$2

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-web-deployment megastoreweb=$ACRNAME.azurecr.io/megastoreweb:$TAG --namespace=$ENVIRONMENT

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-savesalehandler-deployment megastoresavesalehandler=$ACRNAME.azurecr.io/megastoresavesalehandler:$TAG --namespace=$ENVIRONMENT