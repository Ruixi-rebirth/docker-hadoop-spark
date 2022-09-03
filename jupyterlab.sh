#!/bin/bash
sudo chown -R hadoop:hadoop notebooks

jupyter lab --notebook-dir=/home/hadoop/notebooks --ip='*' --port=27649 --no-browser  
