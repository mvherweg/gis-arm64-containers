#!/usr/bin/env sh

osmium_version=`cat version`

# Check whether podman is present, else fall back to docker
command -v podman > /dev/null 2>&1
if [ "$?" = "0" ]; then
    docker_cmd=podman
else
    docker_cmd=docker
fi

$docker_cmd build \
	-f Dockerfile \
	-t docker.io/mvherweg/gis-arm64-osmium:$osmium_version \
	--build-arg alpine_version=3.22 \
	--build-arg boost_version=1.84 \
	--build-arg osmium_version=$osmium_version \
	--squash

