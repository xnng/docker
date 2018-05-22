#!/bin/sh

# 下载 pxc 镜像并改个简短的名字
docker pull percona/percona-xtradb-cluster
docker tag percona/percona-xtradb-cluster pxc:latest

# 创建一个独立网络
docker network create net1

# 创建父节点 pxc
docker run -d -p 3306:3306 -v v1:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=pxc -e XTRABACKUP_PASSWORD=root --privileged --name=node1 --net=net1 pxc

# 创建四个子节点 pxc
docker run -d -p 3307:3306 -v v2:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=pxc -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 --privileged --name=node2 --net=net1 pxc
docker run -d -p 3308:3306 -v v3:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=pxc -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 --privileged --name=node3 --net=net1 pxc
docker run -d -p 3309:3306 -v v4:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=pxc -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 --privileged --name=node4 --net=net1 pxc
docker run -d -p 3310:3306 -v v5:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=pxc -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 --privileged --name=node5 --net=net1 pxc