#!/bin/bash
set -e

DOCKER_USERNAME=${DOCKER_USERNAME:-crazymax}
DOCKER_REPONAME=${DOCKER_REPONAME:-artifactory}
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

if [ -z ${TOKEN} -o ${TOKEN} == "null" ]; then
  echo "Cannot retrieve token. Check your docker's credentials."
  exit 1
fi

TAG_LIST=""
function get_docker_tags() {
  for TAG in $(curl -s -H "Authorization: JWT ${TOKEN}" $1 | jq -rc '.results[]'); do
    TAG_LIST="$(echo "$TAG" | jq -r .name),$TAG_LIST"
  done
  NEXT_PAGE=$(curl -s -H "Authorization: JWT ${TOKEN}" $1 | jq -r '.next')
  if [[ ${NEXT_PAGE} != "null" ]]; then
    get_docker_tags ${NEXT_PAGE}
  fi
}

function docker_pull() {
  echo "### Pulling Artifactory $2 $3 from $1..."
  echo "Check if tag exists..."
  for TAG in $(echo ${TAG_LIST} | sed "s/,/ /g"); do
    if [ "$3" != "latest" ] && [ "$TAG" = "$2-$3" ]; then
      echo "Tag $2-$3 already exists and is not latest... Skipping..."
      return
    fi
  done
  docker pull $1:$3
  docker tag $1:$3 ${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
  docker tag $1:$3 quay.io/${DOCKER_USERNAME}/${DOCKER_REPONAME}:$2-$3
}

# Get all tags
echo "Get all tags..."
get_docker_tags https://hub.docker.com/v2/repositories/${DOCKER_USERNAME}/${DOCKER_REPONAME}/tags/?page_size=10000

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

# Postgres
while IFS= read -r version
do
  docker_pull "docker.bintray.io/jfrog/postgres" "postgres" "$version"
done < "./images/postgres.txt"
