#!/bin/bash
ACRPASSWORD=$1

# Constants not passed in as parameters are populated from environment variables created by the release pipeline

docker-compose -f docker-compose.yml -p $BUILD_REPOSITORY_NAME build $DOCKERCOMPOSESERVICENAME

docker login --username $ACRNAME --password $ACRPASSWORD $ACRNAME.azurecr.io

docker tag $DOCKERCOMPOSEIMAGENAME $ACRNAME.azurecr.io/$DOCKERCOMPOSEIMAGENAME:$BUILD_BUILDNUMBER

docker push $ACRNAME.azurecr.io/$DOCKERCOMPOSEIMAGENAME:$BUILD_BUILDNUMBER