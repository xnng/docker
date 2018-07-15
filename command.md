## docker 三剑客

### machine

>环境：docker-client + VirtualBox

- 查看有多少个 machine

  ```sh
  $ docker-machine ls
  ```

- 创建 machine

  ```
  $ docker-machine create {name}
  ```

- 进入到 machine 里面

  ```
  $ docker-machine ssh {name}
  ```

- 删除 machine

  ```
  $ docker-machine rm {name}
  ```

- 在外面使用 machine

  ```
  $ docker-machine env {name}
  $ {Run this command to configure your shell:}
  ```

- 其他

  ```
  $ docker-machine help
  ```

### compose

`docker-compose.yml` 语法示例：

```yml
version: "3"              #语法版本

services:
  app1:                   #第一个服务的名字
    build: ./app1         #Dockerfile的地址
    image: app1           #构建出来镜像的名字
    ports:                #映射端口
      - 8001:8001
    container_name: app1  #容器名字
    enviroment:
      HOST: 127.0.0.1
    networks:             #要连接的网络名字
      - nnn
    volumes:              #要挂载的数据卷
      - vol:xxx
      
  app2:
    build: ./app2
    networks:
      - nnn
      
networks:                 #创建网络
  nnn:

volumes:                  #创建数据卷
  vol：
```

- 后台运行 compose

    ```
    $ docker-compose up -d
    ```
    
- 停止并删除容器、网络、镜像、数据卷

    ```
    $ docker-compose down
    ```
    
- 进入到服务内

    ```
    $ docker exec service-name bash
    ```
    
scale 横向拓展：

- 首先要删除 `web` 中的 ports

- 然后启动负载均衡器

  ```yml
    version: "3"

    services:

      web:
      image: dockercloud/hello-world:latest

      lb:
        image: dockercloud/haproxy
        links:
          - web
        ports:
          - 8080:80
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock 
    ```

- 最后执行以下命令进行拓展:

    ```
    $ docker-compose up -d
    $ docker-compose up --scale service-name=number -d
    ```



### swarm

- 查看初始化命令行参数
 
  ```
  $ docker swarm init --help
  ```

- 创建 manager 节点
 
  ```
  $ docker swarm init --advertise-addr={ip}
  ```

- 查看节点

  ```
  $ docker node ls
  ```

- 创建服务

  ```
  $ docker service create {name}
  ```

- 查看正在运行的服务

  ```
  $ docker service ps {name}
  ```

- 横向扩展服务

  ```
  $ docker service scale {name}={number}
  ```

- 删除服务

  ```
  $ docker service rm {name}
  ```
