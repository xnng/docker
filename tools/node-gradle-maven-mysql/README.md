## Node.js + Maven/Gradle + Mysql 构建环境参考示例

考虑到数据库不需要频繁构建，所以未写进 docker-compose，所有文件使用时均要修改。

如果是使用 gradle 和 maven，则需要在配置文件中添加阿里云加速否则构建速度会非常缓慢，除非不采用源码直接构建的这种方式。

- maven

在 pox.xml 的 <project> 下添加：

```xml
<repositories>
    <repository>
      <id>public</id>
      <name>aliyun nexus</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <releases>
        <enabled>true</enabled>
      </releases>
    </repository>
</repositories>
<pluginRepositories>
    <pluginRepository>
      <id>public</id>
      <name>aliyun nexus</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <releases>
        <enabled>true</enabled>
      </releases>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
    </pluginRepository>
</pluginRepositories>
```

- gradle

待添加