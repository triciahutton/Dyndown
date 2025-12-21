#!/bin/bash

#create a log file
exec > /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/log_moving_files.log 2>&1

SOURCE_DIR="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/post_proc_out"
DEST_DIR_12KM="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s1978/12km"
#"/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/post_proc_out/12km"
DEST_DIR_4KM="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s1978/4km"
#"/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/post_proc_out/4km"
DEST_DIR_1_33KM="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s1978/1_33km"
#"/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/post_proc_out/1_33km"


#mkdir -p "$DEST_DIR_12KM" "$DEST_DIR_4KM" "$DEST_DIR_1_33KM"

for file in "$SOURCE_DIR"/*; do
    # Check if it's a regular file
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        
        # Move files based on the name containing '12km', '4km', or '1_33km'
        if [[ "$filename" == *12km* ]]; then
            echo "Processing: $file"
            mv "$file" "$DEST_DIR_12KM"
            echo "Moved: $file to $DEST_DIR_12KM"
        elif [[ "$filename" == *4km* ]]; then
            echo "Processing: $file"
            mv "$file" "$DEST_DIR_4KM"
            echo "Moved: $file to $DEST_DIR_4KM"
        elif [[ "$filename" == *1_33km* ]]; then
            echo "Processing: $file"
            mv "$file" "$DEST_DIR_1_33KM"
            echo "Moved: $file to $DEST_DIR_1_33KM"
        fi
    fi
done





