CONFIGPATH=$1
ENV=$2

# MESSAGE_QUEUE_URL configmap (not used directly by message-queue deployment but configured here as used by several components)
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap message.queue --from-literal=MESSAGE_QUEUE_URL=nats://message-queue-service.$ENV:4222 --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# service
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/message-queue-service.yaml --namespace=$ENV

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/message-queue-deployment.yaml --namespace=$ENV