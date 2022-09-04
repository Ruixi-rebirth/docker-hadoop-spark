#!/bin/bash 

sudo chown -R hadoop:hadoop notebooks

#检测/home/hadoop/spark/sbin 下是否存在 start-all.sh、stop-all.sh 文件,
#因为这两个文件名和/home/hadoop/hadoop/etc/hadoop 下的文件重名了, 需要重命名一下
original_start_file="/home/hadoop/spark/sbin/start-all.sh"
modified_start_file="/home/hadoop/spark/sbin/start-all-spark.sh"
original_stop_file="/home/hadoop/spark/sbin/stop-all.sh"
modified_stop_file="/home/hadoop/spark/sbin/stop-all-spark.sh"
if [ -f $original_start_file ]; then 
  mv $original_start_file $modified_start_file
fi 
if [ -f $original_stop_file ]; then 
  mv $original_stop_file $modified_stop_file
fi 

#启动pyspark,这将会打开jupyterlab
pyspark
