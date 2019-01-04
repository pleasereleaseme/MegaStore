CONFIGPATH=$1
ENV=$2

# service
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/message-queue-service.yaml --namespace=$ENV

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/message-queue-deployment.yaml --namespace=$ENV