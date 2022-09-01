FROM ubuntu:latest
RUN useradd -d /home/hadoop/ -m hadoop \
    && echo root:ruixi | chpasswd \
    && echo hadoop:ruixi | chpasswd
WORKDIR /home/hadoop 
COPY jdk-11.0.16_linux-x64_bin.tar.gz ./
COPY .ssh ./.ssh
ADD hadoop-3.3.4 ./hadoop 
ADD spark-3.3.0-bin-hadoop3 ./spark
RUN set -x; pkg='wget iputils-ping iproute2 vim ranger openssh-server openssh-client sudo' \
    && apt update 2> /dev/null \
    && apt install -y $pkg 2> /dev/null\
    && mkdir jdk \
    && tar -zxf jdk-11.0.16_linux-x64_bin.tar.gz -C jdk --strip-components=1 \
    && rm jdk-11.0.16_linux-x64_bin.tar.gz \
    && sed -i "s/#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    && sed -i -e '$ahadoop ALL=(ALL) NOPASSWD: NOPASSWD: ALL' /etc/sudoers \
    && sed -i -e '$asudo service ssh start' .bashrc \
    && chown -R hadoop:hadoop .ssh \
    && chown -R hadoop:hadoop * 
USER hadoop
ENV JAVA_HOME /home/hadoop/jdk
ENV CLASSPATH $JAVA_HOME/lib 
ENV SPARK_HOME=/home/hadoop/spark
ENV HADOOP_HOME /home/hadoop/hadoop 
ENV PATH $JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:.:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
#RUN hdfs namenode -format \ 
#    && start-dfs.sh \
#    && start-yarn.sh \
#    && mapred --daemon start historyserver

