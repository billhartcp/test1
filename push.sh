#!/bin/bash
# Script for loggin into Dockerhub and pushing image to repo
export VERSION=`cat version.txt`
echo "$DOCKER_PW" | docker login -u "$DOCKER_LOGIN" --password-stdin
docker tag local/apachetest:$VERSION crownpeak/apachetest:$VERSION
docker push crownpeak/apachetest:$VERSION
