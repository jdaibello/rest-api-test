#!/bin/bash

# Load Environment Variables
source .env

# Log Environment Variables
echo "COMMIT_HASH_SHORT=${COMMIT_HASH_SHORT}"
echo "KUSTOMIZE_PATH=${KUSTOMIZE_PATH}"
echo "DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}"