#!/bin/bash

#Scipt to build a docker image

if [[ -n "$1" ]]
        then
            echo  "Building caddy with version $1"
            CADDY_VERSION=$1
        else
            echo "Caddy version is not provided. Building with v1.0.4"
            CADDY_VERSION="v1.0.4"
    fi

BUILD_ARG="--build-arg CADDY_VERSION=${CADDY_VERSION}"
IMAGE_NAME="caddy:${CADDY_VERSION}"

docker build -t ${IMAGE_NAME} ${BUILD_ARG} . 
