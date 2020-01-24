#!/bin/bash

#Script to build caddy binary using ubuntu base image

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

#Creating a temp directory to mount to the container
mkdir -p  /tmp/build_output

docker build -t ${IMAGE_NAME} ${BUILD_ARG} . 
