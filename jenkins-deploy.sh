#!/bin/bash

export IMAGE_TAG=jenkins/jenkins:jdk11
export SERVICE_NAME=jenkinsX

docker pull ${IMAGE_TAG}
docker service scale ${SERVICE_NAME}=0
docker service rm ${SERVICE_NAME}
docker service create --replicas 1 \
    --name ${SERVICE_NAME} \
    --publish published=5544,target=2376 \
    --mount type=bind,src=/home/thanachai/jenkins/certs,dst=/certs/client \
    --mount type=bind,src=/home/thanachai/jenkins/home,dst=/var/jenkins_home \
    --env "DOCKER_TLS_CERTDIR=/certs" \
    ${IMAGE_TAG}
    
    
#    --health-cmd='curl -sS http://127.0.0.1:5000/service/status || exit 1' \
#    --health-timeout=10s \
#    --health-retries=3 \
#    --health-interval=5s \
#docker service scale ${SERVICE_NAME}=1
