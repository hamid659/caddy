#!/bin/bash

#Script to build and run a container which listens on port 8080 using Alpine image

if [[ -n "$1" ]]
        then
            echo  "Building caddy with version $1"
            CADDY_VERSION=$1
        else
            echo "Caddy version is not provided. Building with v1.0.4"
            CADDY_VERSION="v1.0.4"
    fi

BUILD_ARG="--build-arg CADDY_VERSION=${CADDY_VERSION}"
IMAGE_NAME="alpine-caddy:${CADDY_VERSION}"

# Build image from docker file
docker build -t ${IMAGE_NAME} ${BUILD_ARG} -f Dockerfile-alpine . 

# Start caddy container

eval "docker run --name caddy -d -p 8080:2015 -i ${IMAGE_NAME} caddy"
