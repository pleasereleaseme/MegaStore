#!/bin/bash
AGENT_TEMPDIRECTORY = $1
ACRNAME = $2
BUILD_BUILDNUMBER = $3
DATENVIRONMENT = $4

kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-web-deployment megastoreweb=$ACRNAME.azurecr.io/megastoreweb:$BUILD_BUILDNUMBER --namespace=$DATENVIRONMENT

kubectl --kubeconfig $1/config set image deployment/megastore-savesalehandler-deployment megastoresavesalehandler=$2.azurecr.io/megastoresavesalehandler:$3 --namespace=$4