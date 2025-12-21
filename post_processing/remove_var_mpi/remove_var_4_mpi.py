#!/usr/bin/env python
import os
import xarray as xr
from glob import glob
import argparse
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

parser = argparse.ArgumentParser(
    description="Remove 'twb' and 'rainc' variables from WRF downscaled 4 km NetCDF files for one or more years (MPI parallel)."
)
parser.add_argument(
    "years",
    nargs="+",
    type=str,
    help="List of years to process (e.g. 1987 1988 1989)"
)
args = parser.parse_args()
years = args.years

input_dir = "/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s2007/4km_WITH_TWB/"
output_dir = "/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s2007/4km_notwb/"
os.makedirs(output_dir, exist_ok=True)

for i, year in enumerate(years):
    # Divide the list of years across ranks
    if i % size != rank:
        continue

    log_file_path = os.path.join(output_dir, f"processing_log_{year}.txt")
    with open(log_file_path, "w") as log:
        print(f"\n=== Rank {rank} processing year {year} ===", file=log)

        file_pattern = os.path.join(input_dir, f"wrf_dscale_4km_{year}*.nc")
        file_list = sorted(glob(file_pattern))

        if not file_list:
            print(f"No files found for {year}", file=log)
            continue

        for input_file in file_list:
            try:
                filename = os.path.basename(input_file)
                output_file = os.path.join(output_dir, filename)

                if os.path.exists(output_file):
                    print(f"Skipped (already exists): {output_file}", file=log)
                    continue  # Skip already processed files

                ds = xr.open_dataset(input_file)
                vars_to_drop = [v for v in ["twb", "rainc"] if v in ds.variables]

                if vars_to_drop:
                    ds = ds.drop_vars(vars_to_drop)

                ds.to_netcdf(output_file)
                print(f"{vars_to_drop} removed and saved to {output_file}", file=log)
                ds.close()

            except Exception as e:
                print(f"Error processing {input_file}: {e}", file=log)

comm.Barrier()
if rank == 0:
    print(" All MPI ranks have completed processing.")
