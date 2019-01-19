#!/bin/bash
ACRPWD=$1

echo "PATH is $K8SCONFIGPATH"
echo "ENV is $ENV"
echo "ACRAUTHENTICATIONSECRETNAME is $ACRAUTHENTICATIONSECRETNAME"
echo "ACRNAME is $ACRNAME"
echo "ACRPWD is $ACRPWD"
echo "APPINSIGHTSINSTRUMENTATIONKEY is $APPINSIGHTSINSTRUMENTATIONKEY"

# namespace
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/namespace-$ENV.yaml

# container registry credentials
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret docker-registry $ACRAUTHENTICATIONSECRETNAME --namespace=$ENV --docker-server=$ACRNAME.azurecr.io --docker-username=$ACRNAME --docker-password=$ACRPWD --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# MESSAGE_QUEUE_URL configmap (not used directly by message-queue deployment but configured here as used by several components)
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap message.queue --from-literal=MESSAGE_QUEUE_URL=nats://message-queue-service.$ENV:4222 --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# APP_INSIGHTS_INSTRUMENTATION_KEY configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap appinsights.env --from-literal=APP_INSIGHTS_INSTRUMENTATION_KEY=$APPINSIGHTSINSTRUMENTATIONKEY --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -
