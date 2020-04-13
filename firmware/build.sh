#!/bin/zsh

TAG="$1"
if [[ -n "$TAG" ]]; then
    ADDITIONAL_TAG="-tzostay/tank-ares-firmware:$TAG"
fi

docker buildx build \
    --platform amd64,arm \
    -t "zostay/tank-ares-firmware:latest" \
    "$ADDITIONAL_TAG" \
    "--push" \
    .
