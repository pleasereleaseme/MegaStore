CONFIGPATH=$1
ENV=$2
DBPWD=$3

echo "TAG is $BUILD_BUILDNUMBER"

# DB_CONNECTION_STRING secret
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config create secret generic db.connection --from-literal=DB_CONNECTION_STRING="Server=tcp:megastore.database.windows.net,1433;Initial Catalog=$ENV;Persist Security Info=False;User ID=sales_user_$ENV;Password=$DBPWD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" --namespace=$ENV --dry-run -o yaml |  kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f -

# deployment
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config apply -f $CONFIGPATH/megastore-savesalehandler-deployment.yaml --namespace=$ENV

# set image
kubectl --kubeconfig $AGENT_TEMPDIRECTORY/config set image deployment/megastore-savesalehandler-deployment megastoresavesalehandler=$ACRNAME.azurecr.io/megastoresavesalehandler:$BUILD_BUILDNUMBER --namespace=$ENV