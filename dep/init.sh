#!/bin/bash
CONFIGPATH=$1
ENV=$2
ACRPWD=$3

echo "PATH is $CONFIGPATH"

# namespace
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/namespace-$ENV.yaml

# container registry credentials
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret docker-registry $ACRAUTHENTICATIONSECRETNAME --namespace=$ENV --docker-server=$ACRNAME.azurecr.io --docker-username=$ACRNAME --docker-password=$ACRPWD --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -