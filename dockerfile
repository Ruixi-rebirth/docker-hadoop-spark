FROM continuumio/anaconda3 
MAINTAINER Ruixi-rebirth <ruixirebirth@gmail.com>
RUN useradd -d /home/hadoop/ -m hadoop \
    && echo root:ruixi | chpasswd \
    && echo hadoop:ruixi | chpasswd
WORKDIR /home/hadoop 
COPY .ssh ./.ssh
ADD jupyterlab.sh ./
RUN set -x; pkg='wget iputils-ping iproute2 vim ranger openssh-server openssh-client sudo nodejs npm' \
    && apt update 2> /dev/null \
    && apt install -y $pkg 2> /dev/null \
    && conda install jupyterlab -y --quiet \
    && mkdir jdk hadoop spark \
    && wget http://23.105.207.7:8888/jdk-11.0.16_linux-x64_bin.tar.gz \
    && wget http://23.105.207.7:8888/spark.tar.gz \
    && wget http://23.105.207.7:8888/hadoop.tar.gz \
    && tar -zxf jdk-11.0.16_linux-x64_bin.tar.gz -C jdk --strip-components=1 \
    && tar -zxf hadoop.tar.gz -C hadoop --strip-components=1 \
    && tar -zxf spark.tar.gz -C spark --strip-components=1 \
    && rm jdk-11.0.16_linux-x64_bin.tar.gz spark.tar.gz hadoop.tar.gz \
    && sed -i "s/#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    && sed -i -e '$ahadoop ALL=(ALL) NOPASSWD: NOPASSWD: ALL' /etc/sudoers \
    && sed -i -e '$asudo service ssh start' .bashrc \
    && chown -R hadoop:hadoop .ssh \
    && chown -R hadoop:hadoop /opt/conda \
    && chmod 600 ./.ssh/id_rsa \
    && chmod +x jupyterlab.sh \
    && mv spark/sbin/start-all.sh spark/sbin/start-all-spark.sh \
    && mv spark/sbin/stop-all.sh spark/sbin/stop-all-spark.sh \
    && chown -R hadoop:hadoop * 
USER hadoop
ENV JAVA_HOME /home/hadoop/jdk
ENV CLASSPATH $JAVA_HOME/lib 
ENV SPARK_HOME=/home/hadoop/spark
ENV HADOOP_HOME /home/hadoop/hadoop 
ENV PATH $JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:.:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

