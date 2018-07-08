#!/bin/bash

createHaproxy(){
    docker run -d \
    -p 4001:8888 -p 4002:3306 \
    -v $PWD/haproxy-data:/usr/local/etc/haproxy \
    --name haproxy1 \
    --privileged \
    --net=pxc haproxy
    
    docker exec -it haproxy1 bash -c \
    "haproxy -f /usr/local/etc/haproxy/haproxy.cfg"
}

createHaproxy
