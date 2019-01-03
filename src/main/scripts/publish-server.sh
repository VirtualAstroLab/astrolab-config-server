#!/usr/bin/env bash


MAVEN="/home/rsouza/Ontwikkeling/apache-maven-3.5.4/bin/mvn"
SERVER_PORT=9090
SERVER_NAME=astrolab-config-server
ORG_NAME=astrolabweb
LOGIN_NAME=rsouza01
IMG_TAG=latest

echo "------------------------------------------------------------------"
echo "Running maven for $SERVER_NAME."
echo "------------------------------------------------------------------"

$MAVEN package -f pom.xml -DskipTests

echo "------------------------------------------------------------------"
echo "Copying $SERVER_NAME.jar."
echo "------------------------------------------------------------------"

cp ./target/$SERVER_NAME-0.0.1-SNAPSHOT.jar ./jar/$SERVER_NAME.jar

echo "------------------------------------------------------------------"
echo "Deleting container $ORG_NAME/$SERVER_NAME:$IMG_TAG."
echo "------------------------------------------------------------------"

sudo docker rm  $ORG_NAME/$SERVER_NAME:$IMG_TAG

echo "------------------------------------------------------------------"
echo "Dockerizing $ORG_NAME/$SERVER_NAME:$IMG_TAG."
echo "------------------------------------------------------------------"

sudo docker build --tag $ORG_NAME/$SERVER_NAME:$IMG_TAG --file ./dockerfiles/Dockerfile.server.yml --rm=true .

echo "------------------------------------------------------------------"
echo "Sending $ORG_NAME/$SERVER_NAME:$IMG_TAG to Docker Hub"
echo "------------------------------------------------------------------"

sudo docker login --username=$LOGIN_NAME

sudo docker push $ORG_NAME/$SERVER_NAME:$IMG_TAG  

echo "------------------------------------------------------------------"
echo "Running docker image."
echo "------------------------------------------------------------------"

#sudo docker run --name=$SERVER_NAME --publish=$SERVER_PORT:$SERVER_PORT -it $SERVER_NAME:latest

echo "------------------------------------------------------------------"
echo "Done!"
echo "------------------------------------------------------------------"
