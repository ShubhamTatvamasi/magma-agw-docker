#!/usr/bin/env bash

set -ex

# dockerhub username:
REGISTRY=shubhamtatvamasi

# magma variables:
MAGMA_ROOT=${PWD}/magma
PUBLISH=${MAGMA_ROOT}/orc8r/tools/docker/publish.sh

# Cloning magma repo:
git clone -b agw-containerization https://github.com/arunuke/magma.git --depth 1

cd ${MAGMA_ROOT}
MAGMA_TAG=$(git rev-parse --short HEAD)

# Deleting docker login code block:
sed -i '65,71d' ${PUBLISH}

# Building Access Gateway docker images:
cd ${MAGMA_ROOT}/lte/gateway/docker
docker-compose build

for image in gateway_c gateway_python
do
  ${PUBLISH} -r ${REGISTRY} -i ${image} -v ${MAGMA_TAG}
done

