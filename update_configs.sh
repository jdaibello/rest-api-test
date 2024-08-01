#!/bin/bash

# Load Environment Variables from GITHUB_ENV
source $GITHUB_ENV

# Log Environment Variables
echo "COMMIT_HASH_SHORT=${COMMIT_HASH_SHORT}"
echo "KUSTOMIZE_PATH=${KUSTOMIZE_PATH}"
echo "DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}"

# Using sed to modify the variables
# sed -i "s/__COMMIT_HASH_SHORT__/${COMMIT_HASH_SHORT}/g" path/to/your/config/file
# sed -i "s/__KUSTOMIZE_PATH__/${KUSTOMIZE_PATH}/g" path/to/your/config/file
# sed -i "s/__DOCKER_IMAGE_TAG__/${DOCKER_IMAGE_TAG}/g" path/to/your/config/file