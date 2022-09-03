#!/bin/bash
mkdir notebooks && jupyter notebook --notebook-dir=/home/hadoop/notebooks --ip='*' --port=27649 --no-browser --allow-root 
