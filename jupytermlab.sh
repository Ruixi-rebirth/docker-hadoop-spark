#!/bin/bash 
 conda install jupyter -y --quiet && \
      mkdir -p /opt/notebooks && \
      jupyter notebook \
      --notebook-dir=/opt/notebooks --ip='*' --port=27649 \
      --no-browser --allow-root"
