#!/usr/bin/env bash

output=$(docker-compose run --rm app 2>&1)
echo "$output"
echo "$output" | grep dev-build-not-for-release
