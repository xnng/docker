#!/bin/bash

createImage(){
	docker pull percona/percona-xtradb-cluster
	docker tag percona/percona-xtradb-cluster:latest pxc:latest
}

createNetwork(){
	docker network create pxc
}

createVolume(){
	docker volume create pxc1
	docker volume create pxc2
	docker volume create pxc3
	docker volume create pxc4
	docker volume create pxc5
}

createMaster(){
	docker run -d -p $1:3306 \
	-v pxc1:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=$2 \
	-e CLUSTER_NAME=pxc \
	-e XTRABACKUP_PASSWORD=root \
	--privileged \
	--name=pxc1 \
	--net=pxc pxc
}

createSlave(){
	sleep 10
	docker run -d -p $(($1 + 1)):3306 \
	-v pxc2:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=$2 \
	-e CLUSTER_NAME=pxc \
	-e XTRABACKUP_PASSWORD=root \
	-e CLUSTER_JOIN=pxc1 \
	--privileged \
	--name=pxc2 \
	--net=pxc pxc

	sleep 3
	docker run -d -p $(($1 + 2)):3306 \
	-v pxc3:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=$2 \
	-e CLUSTER_NAME=pxc \
	-e XTRABACKUP_PASSWORD=root \
	-e CLUSTER_JOIN=pxc1 \
	--privileged \
	--name=pxc3 \
	--net=pxc pxc

	sleep 3
	docker run -d -p $(($1 + 3)):3306 \
	-v pxc4:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=$2 \
	-e CLUSTER_NAME=pxc \
	-e XTRABACKUP_PASSWORD=root \
	-e CLUSTER_JOIN=pxc1 \
	--privileged \
	--name=pxc4 \
	--net=pxc pxc

	sleep 3
	docker run -d -p $(($1 + 4)):3306 \
	-v pxc5:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=$2 \
	-e CLUSTER_NAME=pxc \
	-e XTRABACKUP_PASSWORD=root \
	-e CLUSTER_JOIN=pxc1 \
	--privileged \
	--name=pxc5 \
	--net=pxc pxc
}

inputValue(){
        read -p "Please input the beginning port you want: " port
        read -p "Please input the mysql_root_password you want: " password
}

createImage

createNetwork

createVolume

inputValue

createMaster $port $password

createSlave $port $password
