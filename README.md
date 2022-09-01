<p align="center">Hadoop+Spark 集群环境(一主两从)</p>

*我个人的学习环境，随着学习深入，将不断改进......*

[![Actions Status](https://github.com/Ruixi-rebirth/docker-hadoop/actions/workflows/workflow.yml/badge.svg)](https://github.com/Ruixi-rebirth/docker-hadoop/actions)

#### 一些东西

- Hadoop-3.3.4
- Spark-3.3.0-bin-hadoop3
- JDK-11.0.16
- .ssh 文件夹里面的公钥和私钥可以自己本地生成，每个节点会得到一样的公钥和私钥，方便ssh免密登陆
#### Shot
![](./img/show.png)

1. 克隆仓库到本地
```bash
git clone https://github.com/Ruixi-rebirth/docker-hadoop.git
```

2. 下载必要的组件到context中

    点击此 [链接](http://23.105.207.7:8888/) 进行下载，下载到该项目根目录下

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


