#!/bin/bash -ue

. ./VERSIONS

BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
VCS_REF=$(git rev-parse --verify HEAD)
VERSION=0.0.25

docker build \
        -t "zenko/zenko-cosbench:${VERSION}" \
        --build-arg "COSBENCH_VERSION=${COSBENCH_VERSION}" \
        --build-arg "BUILD_DATE=${BUILD_DATE}" \
        --build-arg "VCS_REF=${VCS_REF}" \
        --build-arg "VERSION=${VERSION}" \
        .

echo "Built zenko-cosbench:${VERSION}"
