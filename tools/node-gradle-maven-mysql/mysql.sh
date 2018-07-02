#!/bin/bash

MYSQL_DATABASE="xxx"
MYSQL_ROOT_PASSWORD="xxx"
MYSQL_VERSION="xxx"

docker run -d -p 3307:3306 --name mysql - v /root/mysql_data:/var/lib/mysql \
-e MYSQL_DATABASE=${MYSQL_DATABASE} -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} mysql:${MYSQL_VERSION}