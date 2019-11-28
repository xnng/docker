#!/bin/bash

echo '拷贝构建文件到项目'
cp Dockerfile ../
cp .dockerignore ../

echo '构建镜像并部署'
docker-compose up -d --build

if [ "$1" = "--clear" ]; then
  echo '删除 none 镜像'
  docker rmi $(docker images | grep 'none' | awk '{print $3}')
fi

echo '删除项目中与开发无关的文件'
rm ../Dockerfile ../.dockerignore
