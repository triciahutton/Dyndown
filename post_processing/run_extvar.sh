#!/bin/sh

#PBS -A WYOM0200
#PBS -N year_WRF_extractvar
#PBS -l walltime=10:00:00
#PBS -q main
#PBS -j oe
#PBS -l select=2:ncpus=128:mpiprocs=128

source ~/miniconda3/bin/activate
conda activate dyndown

WRFDIR="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/out-s1978"
OUTDIR="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/post_proc_out"

START_DATE='19810701'
NDAYS=7
NUM_RUNS=1

LOG_FILE="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/log_date_file.log"
exec >  /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/log_date_file.log 2>&1
echo "Run Start Date: $START_DATE" >> "$LOG_FILE"

exec > "test_WRF_extractvar.${PBS_JOBID}" 2>&1

for i in $(seq 1 $NUM_RUNS); do
	python extract_vars_pool_tricia.py -w $WRFDIR --yrmd $START_DATE -o $OUTDIR --ndays $NDAYS
	START_DATE=$(date -d "$START_DATE + $NDAYS days" +%Y%m%d)
done
