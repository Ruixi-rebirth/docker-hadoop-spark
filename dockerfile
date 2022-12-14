FROM continuumio/anaconda3 
MAINTAINER Ruixi-rebirth <ruixirebirth@gmail.com>
RUN useradd -d /home/hadoop/ -s /bin/bash -m hadoop \
    && echo root:ruixi | chpasswd \
    && echo hadoop:ruixi | chpasswd
WORKDIR /home/hadoop 
COPY .ssh ./.ssh
ADD misc.sh ./
RUN set -x; pkg='wget iputils-ping iproute2 vim ranger openssh-server openssh-client sudo nodejs' \
    && apt update 2> /dev/null \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt install -y $pkg 2> /dev/null \
    && conda install jupyterlab -y --quiet \
    && pip install jupyterlab-lsp  black jupyterlab-code-formatter \
    && mkdir jdk hadoop spark .npm-global \
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
    && chown -R hadoop:hadoop /opt/conda \
    && chmod 600 ./.ssh/id_rsa \
    && chmod +x misc.sh \
    && chown -R hadoop:hadoop .* 
USER hadoop
ENV JAVA_HOME /home/hadoop/jdk
ENV CLASSPATH $JAVA_HOME/lib 
ENV SPARK_HOME=/home/hadoop/spark
ENV HADOOP_HOME /home/hadoop/hadoop 
ENV NPM_CONFIG_PREFIX=/home/hadoop/.npm-global
ENV PYSPARK_PYTHON=/opt/conda/bin/python 
ENV PYSPARK_DRIVER_PYTHON='jupyter'
ENV PYSPARK_DRIVER_PYTHON_OPTS='lab --notebook-dir=/home/hadoop/notebooks --ip='*' --port=27649 --no-browser'
ENV PATH $NPM_CONFIG_PREFIX:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:.:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
