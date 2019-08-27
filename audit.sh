#!/usr/bin/env bash

if sudo docker ps -q &>/dev/null; then
  CONTAINER_ID=$(basename $(cat /proc/1/cpuset))
  DOCKER_COMPOSE_PROJECT=$(sudo docker inspect ${CONTAINER_ID} | grep '"com.docker.compose.project":' | awk '{print $2}' | tr --delete '"' | tr --delete ',')
  export NODE_CONTAINER=$(sudo docker ps -f "name=${DOCKER_COMPOSE_PROJECT}_node_1" --format {{.Names}})

  cd /app
  sudo docker exec -u $(id -u):$(id -g) -w $(pwd) -it ${NODE_CONTAINER} yarn audit
fi
