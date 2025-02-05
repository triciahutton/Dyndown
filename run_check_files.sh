#!/bin/bash

script_dir=/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation

#env
source ~/miniconda3/bin/activate
module load conda 
conda activate dyndown
umask 002

cd ${script_dir}
python ./check_files.py

