#!/bin/bash
ENV=$1
AIKEY=$2
ACRPWD=$3
DBPWD=$4

echo "ENV is $ENV"
echo "ACRPWD is $ACRPWD"
echo "AIKEY is $AIKEY"
echo "DBPWD is $DBPWD"

# container registry credentials
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret docker-registry $ACRAUTHENTICATIONSECRETNAME --namespace=$ENV --docker-server=$ACRNAME.azurecr.io --docker-username=$ACRNAME --docker-password=$ACRPWD --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# ASPNETCORE_ENV configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap aspnetcore.env --from-literal=ASPNETCORE_ENV=$ENV --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# APP_INSIGHTS_INSTRUMENTATION_KEY configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap appinsights.env --from-literal=APP_INSIGHTS_INSTRUMENTATION_KEY=$AIKEY --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# DB_CONNECTION_STRING secret
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret generic db.connection --from-literal=DB_CONNECTION_STRING="Server=tcp:megastore.database.windows.net,1433;Initial Catalog=$ENV;Persist Security Info=False;User ID=sales_user_$ENV;Password='$DBPWD';MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# MESSAGE_QUEUE_URL configmap
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create configmap message.queue --from-literal=MESSAGE_QUEUE_URL=nats://message-queue-service.$ENV:4222 --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -