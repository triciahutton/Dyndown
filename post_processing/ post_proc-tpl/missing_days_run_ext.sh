#!/bin/sh

#PBS -A WYOM0227
#PBS -N 2023_WRF_extractvar
#PBS -l walltime=3:00:00
#PBS -q main
#PBS -j oe
#PBS -l select=2:ncpus=128:mpiprocs=128

source ~/miniconda3/bin/activate
conda activate dyndown

WRFDIR="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/out-s2023"
OUTDIR="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s2023/post_proc_out"

START_DATE='20280502'
NDAYS=18
NUM_RUNS=1

#LOG_FILE="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s2023/log_date_file.log"
#exec >  /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s2023/log_date_file.log 2>&1
#echo "Run Start Date: $START_DATE" >> "$LOG_FILE"

exec > /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s2023/2023_WRF_extractvar.${PBS_JOBID} 2>&1

for i in $(seq 1 $NUM_RUNS); do
        python /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s2023/extract_vars_pool_tricia.py -w $WRFDIR --yrmd $START_DATE -o $OUTDIR --ndays $NDAYS
        START_DATE=$(date -d "$START_DATE + $NDAYS days" +%Y%m%d)
done
