## 创建五节点的 MySQL PXC 集群

```sh
$ mysql-pxc.sh
```

接收两个参数，第一个 MySQL 实例的起始端口号和数据库的密码

## 创建 Haproxy 负载均衡器

- 首先要在之前的数据库中创建一个无密码的账户，用来做心跳检测

```sh
$ docker exec -it pxc1 bash
$ mysql -uroot -ppassword -e "create user 'haproxy'@'%' IDENTIFIED BY '';"
```

- 然后运行 Haproxy 容器

```sh

```