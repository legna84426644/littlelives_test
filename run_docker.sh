#!/usr/bin/env bash

docker run --rm \
           -e USERNAME="thanh" \
           --net=host \
           -v "$PWD/Common":/Common \
           -v "$PWD/Reports":/Reports \
           -v "$PWD/Tests":/Tests \
           -v "$PWD/scripts":/scripts \
           --security-opt seccomp:unconfined \
           --shm-size "256M" \
           --privileged \
           lhthanh/littlelives:1.0