#!/bin/bash

DOCKER_USERNAME=${DOCKER_USERNAME:-crazymax}
DOCKER_REPONAME=${DOCKER_REPONAME:-artifactory}
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' https://registry.hub.docker.com/v2/users/login/ | jq -r .token)

if [ -z ${TOKEN} -o ${TOKEN} == "null" ]; then
  echo "Cannot retrieve token. Check your docker's credentials."
  exit 1
fi

function docker_pull() {
  echo "### Pulling Artifactory $2 $3 from $1..."
  TAG_EXISTS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://registry.hub.docker.com/v2/repositories/${DOCKER_USERNAME}/${DOCKER_REPONAME}/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2-$3\"] | any")
  echo "Check tag exists : $TAG_EXISTS"
  if [ "$3" != "latest" ] && [ "${TAG_EXISTS}" = "true" ]; then
    echo "Tag $2-$3 already exists and is not latest... Skipping..."
  else
    docker pull $1:$3
    docker tag $1:$3 ${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
    docker tag $1:$3 quay.io/${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
  fi
}

# Artifactory oss
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/artifactory-oss" "oss" "$version"
done < "./images/artifactory-oss.txt"

# Artifactory pro
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/artifactory-pro" "pro" "$version"
done < "./images/artifactory-pro.txt"

# Nginx Artifactory pro
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/nginx-artifactory-pro" "nginx-pro" "$version"
done < "./images/nginx-artifactory-pro.txt"
