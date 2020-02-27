#!/usr/bin/env bash

docker run --rm \
           -e USERNAME="thanh" \
           --net=host \
           -v "$PWD/Common":/Common \
           -v "$PWD/Reports":/Reports \
           -v "$PWD/Tests":/Tests \
           --security-opt seccomp:unconfined \
           --shm-size "256M" \
           thanh