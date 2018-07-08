#!/bin/bash

createHaproxy(){
    docker run -d \
    -p 40001:8888 -p 4002:3306 \
    --name haproxy1 \
    --privileged \
    --net=pxc haproxy
}

createHaproxy