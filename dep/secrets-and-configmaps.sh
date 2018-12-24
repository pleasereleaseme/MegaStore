#!/bin/bash
ENVIRONMENT=$1
ACRPASSWORD=$2
APPINSIGHTSINSTRUMENTATIONKEY=$3
DBPWD=$4

# container registry credentials
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret docker-registry $ACRAUTHENTICATIONSECRETNAME --namespace=$ENVIRONMENT --docker-server=$ACRNAME.azurecr.io --docker-username=$ACRNAME --docker-password=$ACRPASSWORD --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# ASPNETCORE_ENVIRONMENT configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap aspnetcore.env --from-literal=ASPNETCORE_ENVIRONMENT=$ENVIRONMENT --namespace=$ENVIRONMENT --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# APP_INSIGHTS_INSTRUMENTATION_KEY configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap appinsights.env --from-literal=APP_INSIGHTS_INSTRUMENTATION_KEY=$APPINSIGHTSINSTRUMENTATIONKEY --namespace=$ENVIRONMENT --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# DB_CONNECTION_STRING secret
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret generic db.connection --from-literal=DB_CONNECTION_STRING="Server=tcp:megastore.database.windows.net,1433;Initial Catalog=$ENVIRONMENT;Persist Security Info=False;User ID=sales_user_$ENVIRONMENT;Password=$DBPWD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" --namespace=$ENVIRONMENT --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# MESSAGE_QUEUE_URL configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap message.queue --from-literal=MESSAGE_QUEUE_URL=nats://message-queue-service.$ENVIRONMENT:4222 --namespace=$ENVIRONMENT --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -