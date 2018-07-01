## Docker 中用 nginx 配置多域名多端口

修改 default.conf 文件中的前两个 server，改成自己要配置的域名和端口，然后：

```
$ git clone https://github.com/ifkingx/Docker-Learn.git

$ cd tools/nginx

$ vi default.conf

$ docker-compose up -d
```