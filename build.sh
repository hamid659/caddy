#!/bin/bash

#Script to build caddy binary using ubuntu base image

#Function to verify the  git tag
verify_git_tag () {
 repo="https://github.com/caddyserver/caddy"
 if [[ "$#" -ne "1" ]]; then
   echo "Usage: $0 [version]"
 fi
 version=$1
 git ls-remote --heads --tags $repo | grep -E "refs/(heads|tags)/${version}$" >/dev/null
 if [[ "$?" -eq "0" ]]; then
   return 0
 else
   echo "Unknown version $version"
   return 1
fi
}

#Verify user input
if [[ -n "$1" ]]
        then
           if verify_git_tag $1; then          
            echo  "Building caddy with version $1"
            CADDY_VERSION=$1
           else
             exit
           fi
        else
            echo "Caddy version is not provided. Building with v1.0.4"
            CADDY_VERSION="v1.0.4"
    fi


BUILD_ARG="--build-arg CADDY_VERSION=${CADDY_VERSION}"
IMAGE_NAME="caddy:${CADDY_VERSION}"

#Creating a temp directory to mount to the container
mkdir -p  /tmp/build_output

docker build -t ${IMAGE_NAME} ${BUILD_ARG} . 
