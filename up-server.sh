#!/usr/bin/env bash



MAVEN="/home/rsouza/Ontwikkeling/apache-maven-3.5.4/bin/mvn"
SERVER_PORT=9090
SERVER_NAME=astrolab-config-server

echo "------------------------------------------------------------------"
echo "Running maven."
echo "------------------------------------------------------------------"

$MAVEN package -f pom.xml -DskipTests

echo "------------------------------------------------------------------"
echo "Copying jar."
echo "------------------------------------------------------------------"
cp ./target/$SERVER_NAME-0.0.1-SNAPSHOT.jar ./jar/$SERVER_NAME.jar

echo "------------------------------------------------------------------"
echo "Deleting container."
echo "------------------------------------------------------------------"

sudo docker rm  $SERVER_NAME

echo "------------------------------------------------------------------"
echo "Dockerizing."
echo "------------------------------------------------------------------"

sudo docker build --tag $SERVER_NAME:latest --file ./dockerfiles/Dockerfile.server.yml --rm=true .

echo "------------------------------------------------------------------"
echo "Running docker image."
echo "------------------------------------------------------------------"

sudo docker run --name=$SERVER_NAME --publish=$SERVER_PORT:$SERVER_PORT -it $SERVER_NAME:latest

echo "------------------------------------------------------------------"
echo "Done!"
echo "------------------------------------------------------------------"


# java -jar ../target/astrolab-config-server-0.0.1-SNAPSHOT.jar
