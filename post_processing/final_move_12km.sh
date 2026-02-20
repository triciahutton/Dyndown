#!/bin/bash

#SRC_BASE='/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s1978/post_proc_out/12km'

SRC_BASE='/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s2095/12km'

#DST_BASE='/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/spinup'
DST_BASE='/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/spinup'

#first finding the end of the spin up time- the first time 07/01 is found 
first_july1=$(ls "$SRC_BASE"/wrf_dscale_12km_????-07-01.nc | sort | head -n 1)
start_date=${first_july1: -13:10}
echo "The first day after spin up is: $start_date"

#for file in $(ls "$SRC_BASE"/wrf_dscale_*.nc | sort | head -n 3); do
for file in "$SRC_BASE"/wrf_*.nc; do
        file_name=$(basename "$file")
        file_date=${file_name: -13:10}
        file_year=${file_name: -13:4}
        file_resolution=${file_name: -18:4}
        #echo "file resolution : $file_resolution"
        echo "file name :$file_name , file year : $file_year"
        if [[ "$file_date" < "$start_date" ]]; then
                echo "$file_date is BEFORE the first July 1 (spin-up), move these files!"
                mv $file $DST_BASE/$file_name
                echo "files have been moved!"   
        else
                echo "$file_date is ON or AFTER the first July 1, keep in folder"
                #ln -sf $file $DST_BASE/$file_resolution/$file_year/$file_name
                #echo "linked file to $file_resolution/$file_year"
        fi
done
