## 笔记

- [Docker 的基本概念和基本操作](https://xnngs.cn/old/docker1.html)

- [Dockerfile 和 docker-compose 的简单应用](https://xnngs.cn/old/docker2.html) [(用到的文件)](./libs/dockerfile-compose/)

- [在日常开发过程中用 Docker 进行 CI/CD](https://xnngs.cn/old/docker3.html)

## 示例

- [Docker 容器中使用 Jenkins](./tools/jenkins/)

- [Docker 中用 nginx 配置多域名多端口](./tools/nginx/)

- [Node.js + Maven/Gradle + Mysql 构建环境参考示例](./tools/node-gradle-maven-mysql/)

- [五节点 MySQL PXC 集群 + 单节点 haproxy 实现高性能、高负载](./tools/mysql-pxc-haproxy)

- [五节点 MySQL PXC 集群 + 双节点 haproxy 集群 + Keepalived 实现高性能、高负载、高可用](./tools/mysql-pxc-haproxy-keepalived)

## FAQ

- [遇到过的问题](./questions.md)

## 常用 docker-compose

- mongodb

```yaml
version: '3.1'

services:

  mongo:
    image: mongo
    restart: always
    container_name: mongodb
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: root
    volumes:
      - $PWD/mongodb_data:/data/db
    ports:
      - 27017:27017
    container_name: mongo

  mongo-express:
    image: mongo-express
    container_name: mongo-express
    restart: always
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: root
      ME_CONFIG_MONGODB_ADMINPASSWORD: root
```

>mongo-express 为网页版图形化管理工具，可移除

- mysql

```yaml
version: '3.1'

services:

  db:
    image: mysql
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
    container_name: mysql
    ports:
      - 3306:3306
    volumes:
      - $PWD/docker/mysql-data:/var/lib/mysql
```

>command 作用是将 mysql 8 的密码认证方式改成 5.7 的

- postgresql

```yaml
version: "3.1"

services:
  db:
    image: postgres
    restart: always
    container_name: postgresql
    volumes:
      - $PWD/postgresql_data:/var/lib/postgresql/data
    ports:
      - 5432:5432
    environment:
      POSTGRES_PASSWORD: root
```

>用户名未指定时默认为 postgres