#!/bin/bash
if [[ -z "$GH_USERNAME" ]]; then
    echo "Please enter your github username into \$GH_USERNAME!"
fi
if [[ -z "$CR_PAT" ]]; then
    echo "Please enter your PAT into \$CR_PAT! (it must have package registry upload permissions)"
    exit 1
fi
echo "$CR_PAT" | docker login ghcr.io -u $GH_USERNAME --password-stdin &> /dev/null
if [[ $? -ne 0 ]]; then
    echo "Could not log in"
    exit 1
else
    echo "Logged in"
fi
if [[ "$1" == "--tag" ]]; then
    VERSION=$(git describe --tags --abbrev=0)
else
    if [[ -z "$1" ]]; then
        VERSION="non-release"
    else
        VERSION="$1"
    fi
fi
IMAGE_NAME="ghcr.io/$GH_USERNAME/kube-playground:$VERSION"
docker build . -t $IMAGE_NAME &> /dev/null
if [[ $? -ne 0 ]]; then
    echo "Could not build image"
    exit 1
else
    echo "Built image"
fi
docker push $IMAGE_NAME &> /dev/null
if [[ $? -ne 0 ]]; then
    echo "Could not push image"
    exit 1
else
    echo "Finished uploading image"
fi