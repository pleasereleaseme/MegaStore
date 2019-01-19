#!/bin/bash
DBPASSWORD=$1

echo "PATH is $K8SCONFIGPATH"
echo "RELEASE_ENVIRONMENTNAME is $RELEASE_ENVIRONMENTNAME"
echo "DBPASSWORD is $DBPASSWORD"
echo "BUILD_BUILDNUMBER is $BUILD_BUILDNUMBER"

# DB_CONNECTION_STRING secret
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret generic db.connection --from-literal=DB_CONNECTION_STRING="Server=tcp:megastore.database.windows.net,1433;Initial Catalog=$RELEASE_ENVIRONMENTNAME;Persist Security Info=False;User ID=sales_user_$RELEASE_ENVIRONMENTNAME;Password=$DBPASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" --namespace=$RELEASE_ENVIRONMENTNAME --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $K8SCONFIGPATH/megastore-savesalehandler-deployment.yaml --namespace=$RELEASE_ENVIRONMENTNAME

# set image
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-savesalehandler-deployment megastoresavesalehandler=$ACRNAME.azurecr.io/megastoresavesalehandler:$BUILD_BUILDNUMBER --namespace=$RELEASE_ENVIRONMENTNAME