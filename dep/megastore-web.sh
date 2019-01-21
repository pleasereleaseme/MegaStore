#!/bin/bash

# Constants not passed in as parameters are populated from environment variables created by the release pipeline

echo "K8SCONFIGPATH is $K8SCONFIGPATH"
echo "RELEASE_ENVIRONMENTNAME is $RELEASE_ENVIRONMENTNAME"
echo "ACRNAME is $ACRNAME"
echo "BUILD_BUILDNUMBER is $BUILD_BUILDNUMBER"

# ASPNETCORE_ENV configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap aspnetcore.env --from-literal=ASPNETCORE_ENVIRONMENT=$RELEASE_ENVIRONMENTNAME --namespace=$RELEASE_ENVIRONMENTNAME --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# service
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/megastore-web-service.yaml --namespace=$RELEASE_ENVIRONMENTNAME

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/megastore-web-deployment.yaml --namespace=$RELEASE_ENVIRONMENTNAME

# set image
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-web-deployment megastoreweb=$ACRNAME.azurecr.io/megastoreweb:$BUILD_BUILDNUMBER --namespace=$RELEASE_ENVIRONMENTNAME