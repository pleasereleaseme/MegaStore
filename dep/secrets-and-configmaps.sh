#!/bin/bash
AGENT_TEMPDIRECTORY=$1
ACRNAME=$2
BUILD_BUILDNUMBER=$3
ENVIRONMENT=$4

# image pull secret
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret docker-registry $(AcrAuthenticationSecretName) --namespace=$(DatEnvironment) --docker-server=$ACRNAME.azurecr.io --docker-username=$ACRNAME --docker-password=$(AcrPassword) --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# ASPNETCORE_ENVIRONMENT configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap aspnetcore.env --from-literal=ASPNETCORE_ENVIRONMENT=$(DatEnvironment) --namespace=$(DatEnvironment) --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# APP_INSIGHTS_INSTRUMENTATION_KEY configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap appinsights.env --from-literal=APP_INSIGHTS_INSTRUMENTATION_KEY=$(DatAppInsightsInstrumentationKey) --namespace=$(DatEnvironment) --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# DB_CONNECTION_STRING secret
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret generic db.connection --from-literal=DB_CONNECTION_STRING="$(DatDbConn)" --namespace=$(DatEnvironment) --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# MESSAGE_QUEUE_URL configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap message.queue --from-literal=MESSAGE_QUEUE_URL=nats://message-queue-service.$(DatEnvironment):4222 --namespace=$(DatEnvironment) --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -