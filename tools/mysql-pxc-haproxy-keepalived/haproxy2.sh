#!/bin/bash

createHaproxy(){
    docker run -d \
    -p 4003:8888 -p 4004:3306 \
    -v $PWD/keepalived/h2:/usr/local/etc/haproxy \
    --name haproxy2 \
    --privileged \
    --net=pxc \
    --ip=172.25.0.22 haproxy
    
    docker exec -it haproxy1 bash -c \
    "haproxy -f /usr/local/etc/haproxy/haproxy.cfg"
}

createHaproxy

