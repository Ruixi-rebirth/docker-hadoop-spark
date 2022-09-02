<h3 align="center">Hadoop+Spark 集群环境(一主两从)</h3>

*我个人的学习环境，随着学习深入，将不断改进......*

[![Actions Status](https://github.com/Ruixi-rebirth/docker-hadoop/actions/workflows/workflow.yml/badge.svg)](https://github.com/Ruixi-rebirth/docker-hadoop/actions)

### 环境详情
|名称|IP|说明|JDK版本|Hadoop版本|Spark版本|操作系统|
|---|---|---|---|---|---|---|
|hadoop-master|172.18.1.2|Master节点|11.0.16|3.3.4|3.3.0|Ubuntu:latest|
|hadoop-slave1|172.18.1.3|Slave节点|11.0.16|3.3.4|3.3.0|Ubuntu:latest|
|hadoop-slave2|172.18.1.4|Slave节点|11.0.16|3.3.4|3.3.0|Ubuntu:latest|

- hadoop部署说明: 完全分布式模式(集群模式),Master 节点仅作为 NameNode 使用, slave 节点 为 DataNode

- spark部署说明: Spark On YARN*(Yet Another Resource Negotiator, 另一种资源协调者)*, 即 Spark 运行在Hadoop YARN框架之上的一种模式

- .ssh 文件夹里面的公钥和私钥可以自己本地生成，每个节点会得到一样的公钥和私钥，方便ssh免密登陆
### 截屏
![](./img/show.png)

### 使用 
1. 克隆仓库到本地
```bash
git clone https://github.com/Ruixi-rebirth/docker-hadoop.git
```

2. 下载必要的组件到context中

    点击此 [链接](http://23.105.207.7:8888/) 进行下载，下载到该项目根目录下
    **说明:** hadoop和spark压缩包是我修改过配置文件的
3. 后台启动容器 
```bash
docker compose up -d
```
4. 与容器进行交互
```bash
docker attach hadoop-master

docker attach hadoop-slave1

docker attach hadoop-slave2
```


