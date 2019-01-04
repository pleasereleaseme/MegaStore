CONFIGPATH=$1
ENV=$2

echo "ENV is $BUILD_BUILDNUMBER"

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/megastore-savesalehandler-deployment.yaml --namespace=$ENV

# set image
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-savesalehandler-deployment megastoresavesalehandler=$ACRNAME.azurecr.io/megastoresavesalehandler:$BUILD_BUILDNUMBER --namespace=$ENV