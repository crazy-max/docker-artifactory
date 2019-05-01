#!/bin/bash
set -e

DOCKER_USERNAME=${DOCKER_USERNAME:-crazymax}
DOCKER_REPONAME=${DOCKER_REPONAME:-artifactory}
QUAY_USERNAME=${QUAY_USERNAME:-crazymax}
QUAY_REPONAME=${QUAY_REPONAME:-artifactory}

if [ ! -z ${DOCKER_PASSWORD} ]; then
  echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
  docker push ${DOCKER_USERNAME}/${DOCKER_REPONAME}
fi

if [ ! -z ${QUAY_PASSWORD} ]; then
  echo "$QUAY_PASSWORD" | docker login quay.io --username "$QUAY_USERNAME" --password-stdin
  docker push quay.io/${DOCKER_USERNAME}/${DOCKER_REPONAME}
fi
