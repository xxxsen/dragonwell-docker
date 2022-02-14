#!/bin/bash

GITHUB=https://github.com
RELEASE=$GITHUB/alibaba/dragonwell17/releases

URI=$(curl -v -L $RELEASE 2>/dev/null |grep latest -A 100 | grep dragonwell |grep x64_linux.tar.gz |grep -v sha256.txt | awk -F "\"" '{print $2}')
DURL=$GITHUB$URI
VERSION=$(echo $DURL | awk -F"/" '{print $9}' | awk -F"_" '{print $3}')
echo "VERSION:$VERSION, DOWNLOAD URL:$DURL"
VERSION=$(echo $VERSION|sed 's/+/-/g')

IMAGE=xxxsen/dragonwell:$VERSION
IMAGE_LATEST=xxxsen/dragonwell:latest
docker build --build-arg DOWNLOAD_URL=$DURL -t $IMAGE .
docker push $IMAGE 
docker tag $IMAGE $IMAGE_LATEST
docker push $IMAGE_LATEST
