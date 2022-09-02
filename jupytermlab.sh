#!/bin/bash 
 conda install jupyter -y --quiet && \
      mkdir -p /opt/notebooks && \
      jupyter notebook \
      --notebook-dir=/opt/notebooks --ip='*' --port=8888 \
      --no-browser --allow-root"
