#!/bin/bash
#PBS -A WYOM0200
#PBS -N 2007133removing_vars_mpi
#PBS -l walltime=10:00:00
#PBS -q main
#PBS -j oe
#PBS -l select=1:ncpus=128:mpiprocs=128

source ~/miniconda3/bin/activate
conda activate dyndown

cd /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s2007/

mpiexec -n 3 python remove_var_12_mpi.py 2007 2008 2009

