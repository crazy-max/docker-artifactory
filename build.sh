#!/bin/bash

DOCKER_USERNAME=${DOCKER_USERNAME:-"crazymax"}
DOCKER_PASSWORD=${DOCKER_PASSWORD:-""}
DOCKER_REPONAME=${DOCKER_REPONAME:-"artifactory"}

function docker_tag_exists() {
  TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
  echo $(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
}

function docker_build() {
  echo "### Start building Artifactory $2 $3..."
  TAG_EXISTS=$(docker_tag_exists "${DOCKER_USERNAME}/${DOCKER_REPONAME}" "$2-$3")
  echo "Check tag exists : $TAG_EXISTS"
  if [ "$3" != "latest" ] && [ "${TAG_EXISTS}" = "true" ]; then
    echo "Tag $2-$3 already exists and is not latest..."
  else
    mkdir -p ./docker/$2-$3
    echo "FROM $1:$3" > ./docker/$2-$3/Dockerfile
    docker build -t $2-$3 -f ./docker/$2-$3/Dockerfile ./docker/$2-$3
    docker tag $2-$3 ${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
  fi
}

### START
rm -rf ./docker

# Artifactory oss
while IFS= read -r version
do
  docker_build "docker.bintray.io/jfrog/artifactory-oss" "oss" "$version"
done < "./images/artifactory-oss.txt"

# Artifactory pro
while IFS= read -r version
do
  docker_build "docker.bintray.io/jfrog/artifactory-pro" "pro" "$version"
done < "./images/artifactory-pro.txt"

# Nginx Artifactory pro
while IFS= read -r version
do
  docker_build "docker.bintray.io/jfrog/nginx-artifactory-pro" "nginx-pro" "$version"
done < "./images/nginx-artifactory-pro.txt"
