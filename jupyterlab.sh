#!/bin/bash
jupyter lab --notebook-dir=/home/hadoop/notebooks --ip='*' --port=27649 --no-browser  
sudo chown -R hadoop:hadoop notebooks
