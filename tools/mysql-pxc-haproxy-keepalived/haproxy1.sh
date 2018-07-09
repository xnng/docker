#!/bin/bash

createHaproxy(){
    docker run -d \
    -p 4001:8888 -p 4002:3306 \
    -v $PWD/keepalived/h1:/usr/local/etc/haproxy \
    --name haproxy1 \
    --privileged \
    --net=pxc \
    --ip=172.25.0.21 haproxy
    
    docker exec -it haproxy1 bash -c \
    "haproxy -f /usr/local/etc/haproxy/haproxy.cfg"
}

createHaproxy

