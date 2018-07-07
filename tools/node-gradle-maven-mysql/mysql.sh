#!/bin/bash

createDatabase(){
    docker run -d -p $1:3306 --name my_mysql \
    -v $PWD/mysql_data:/var/lib/mysql \
    -e MYSQL_DATABASE=$2 \
    -e MYSQL_ROOT_PASSWORD=$3 \
    mysql:$4
}

inputValue(){
    read -p "Please input the port you want: " port
    read -p "Please input the databaseName you want: " databaseName
    read -p "Please input the password you want: " password
    read -p "Please input the version you want: " version
}

inputValue
createDatabase $port $databaseName $password $version
