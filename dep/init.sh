#!/bin/bash
ACRPASSWORD=$1

echo "PATH is $K8SCONFIGPATH"
echo "RELEASE_ENVIRONMENTNAME is $RELEASE_ENVIRONMENTNAME"
echo "ACRAUTHENTICATIONSECRETNAME is $ACRAUTHENTICATIONSECRETNAME"
echo "ACRNAME is $ACRNAME"
echo "ACRPASSWORD is $ACRPASSWORD"
echo "APPINSIGHTSINSTRUMENTATIONKEY is $APPINSIGHTSINSTRUMENTATIONKEY"

# namespace
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/namespace-$RELEASE_ENVIRONMENTNAME.yaml

# container registry credentials
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret docker-registry $ACRAUTHENTICATIONSECRETNAME --namespace=$RELEASE_ENVIRONMENTNAME --docker-server=$ACRNAME.azurecr.io --docker-username=$ACRNAME --docker-password=$ACRPASSWORD --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# MESSAGE_QUEUE_URL configmap (not used directly by message-queue deployment but configured here as used by several components)
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap message.queue --from-literal=MESSAGE_QUEUE_URL=nats://message-queue-service.$RELEASE_ENVIRONMENTNAME:4222 --namespace=$RELEASE_ENVIRONMENTNAME --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# APP_INSIGHTS_INSTRUMENTATION_KEY configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap appinsights.RELEASE_ENVIRONMENTNAME --from-literal=APP_INSIGHTS_INSTRUMENTATION_KEY=$APPINSIGHTSINSTRUMENTATIONKEY --namespace=$RELEASE_ENVIRONMENTNAME --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -
