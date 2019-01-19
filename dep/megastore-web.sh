#!/bin/bash

echo "PATH is $K8SCONFIGPATH"
echo "ENV is $ENV"
echo "TAG is $BUILD_BUILDNUMBER"

# ASPNETCORE_ENV configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap aspnetcore.env --from-literal=ASPNETCORE_ENVIRONMENT=$ENV --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# service
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/megastore-web-service.yaml --namespace=$ENV

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/megastore-web-deployment.yaml --namespace=$ENV

# set image
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-web-deployment megastoreweb=$ACRNAME.azurecr.io/megastoreweb:$BUILD_BUILDNUMBER --namespace=$ENV