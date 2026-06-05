#!/usr/bin/env bash

logFail() {
    echo "${1}"
    exit 1
}

id=$(docker-compose run -d app)
logs=$(docker logs "$id")
echo "$logs" | grep -q panic
result=$?
docker stop "$id" || logFail 'should still be running'

if [ "$result" -eq 0 ]; then
    logFail 'should not panic'
fi
exit 0
