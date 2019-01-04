CONFIGPATH=$1
ENV=$2
TAG=$3

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/megastore-savesalehandler-deployment.yaml --namespace=$ENV

# set image
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-savesalehandler-deployment megastoresavesalehandler=$ACRNAME.azurecr.io/megastoresavesalehandler:$TAG --namespace=$ENV