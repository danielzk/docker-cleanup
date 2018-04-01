#!/bin/sh

# 3600s = 1 hour
CLEAN_INTERVAL="${CLEAN_INTERVAL:-3600}"

DOCKER_API_VERSION=$(docker version --format '{{.Server.APIVersion}}')
CONTAINER_IDS=$(docker ps -qa --no-trunc --filter "status=exited")
NETWORK_IDS=$(docker network ls | awk '/ / { if(NR>1) print $1 }')
IMAGE_IDS=$(docker images -qa)

version() { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

while true; do
  echo Script started

  if [ $(version $DOCKER_API_VERSION) -ge $(version "1.25") ]; then
    echo "=> Running docker prune..."
    docker system prune -fa
    echo Done
  else
    echo "=> Removing containers..."
    if [ -z "${CONTAINER_IDS}" ]; then
      echo No containers found
    else
      docker rm $CONTAINER_IDS
    fi
    echo Done

    echo "=> Removing networks..."
    if [ -z "${NETWORK_IDS}" ]; then
      echo No networks found
    else
      docker network rm $NETWORK_IDS
    fi
    echo Done

    echo "=> Removing images..."
    if [ -z "${IMAGE_IDS}" ]; then
      echo No images found
    else
      docker rmi $IMAGE_IDS
    fi
    echo Done
  fi

  echo "Script finished\n\n"
  sleep $CLEAN_INTERVAL
done
