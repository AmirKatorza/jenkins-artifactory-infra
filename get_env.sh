#!/bin/sh

cat << EOF > .env
JENKINS_IMAGE=docker.io/jenkins/jenkins
JENKINS_TAG=lts  # see tags here: https://hub.docker.com/r/jenkins/jenkins/tags
HOST_DOCKER_GID=$(getent group docker | cut -d ":" -f 3)
JENKINS_PORT=8080
DOCKER_REGISTRY=releases-docker.jfrog.io
ARTIFACTORY_VERSION=7.63.14
ROOT_DATA_DIR=\$HOME/.jfrog/artifactory
JF_ROUTER_ENTRYPOINTS_EXTERNALPORT=8082
M2_CACHE_VOL=m2_cache
EOF
