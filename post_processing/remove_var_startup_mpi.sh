#!/bin/sh

echo $1

yr=$1

if [[ yr -lt 1978 || yr -gt 2100 ]]; then
echo "bad year entry"
exit
fi

source_dir="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/remove_var_mpi"
destination_dir="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s${yr}"

cd remove_var_mpi
cp -r *.sh /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s${yr}
cp -r *.py /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s${yr}

cd $destination_dir

old_path="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s2007"
new_path="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s${yr}"

for file in *.sh *.py; do
  sed -i "s|$old_path|$new_path|g" $file
done

wyo_old_path="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s2007"
wyo_new_path="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s${yr}"
for file in *.sh *.py; do
  sed -i "s|$wyo_old_path|$wyo_new_path|g" $file
done

cd ../..

exit
