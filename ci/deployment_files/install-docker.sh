#!/bin/bash

set -euo pipefail
echo "Update system ....."
sudo apt-get update

echo "Install docker ....."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "Docker version ....."
docker version

echo "Checking if service is up ....."
set +e
sudo service docker status
retCode=$(echo $?)
set -e

echo "Starting docker service ....."
test $retCode -ne 0 && sudo service docker start || echo "Service is already up ....."

echo "Logging into the docker registry ....."
set +e
sudo docker login -u $DOCKER_USER -p $DOCKER_CREDS $DOCKER_MYHOST
retCode=$(echo $?)
set -e
test $retCode -ne 0 && exit 1 || echo "Login successful ....." 

echo "Launching the application container ....."
sudo docker run -it -d $DOCKER_MYHOST/python-demo-buzz

echo "Sleep for 20 seconds to allow container to come up ....."
sleep 20

echo "Checking for running docker processes ....."
sudo docker ps -a