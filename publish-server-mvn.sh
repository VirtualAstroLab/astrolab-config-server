#!/usr/bin/env bash

# Do not forget to enable docker
# sudo chmod 777 /var/run/docker.sock

MAVEN="/home/rsouza/Ontwikkeling/apache-maven-3.5.4/bin/mvn"

echo "[INFO] ------------------------------------------------------------------------"
echo "[INFO] Importing settings."
echo "[INFO] ------------------------------------------------------------------------"

source ./publish-server-settings.sh

echo "[INFO] ------------------------------------------------------------------------"
echo "[INFO] Running maven for $SERVER_NAME."
echo "[INFO] ------------------------------------------------------------------------"

$MAVEN clean package -f pom.xml -DskipTests

echo "[INFO] ------------------------------------------------------------------------"
echo "[INFO] Dockerizing $ORG_NAME/$SERVER_NAME:$IMG_TAG."
echo "[INFO] ------------------------------------------------------------------------"

$MAVEN docker:build -e

echo "[INFO] ------------------------------------------------------------------------"
echo "[INFO] Sending $ORG_NAME/$SERVER_NAME:$IMG_TAG to Docker Hub"
echo "[INFO] ------------------------------------------------------------------------"

$MAVEN docker:push

echo "[INFO] ------------------------------------------------------------------------"
echo "[INFO] Done!"
echo "[INFO] ------------------------------------------------------------------------"
