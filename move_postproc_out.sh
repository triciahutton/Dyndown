#!/bin/bash

#create a log file
exec > /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation/log_moving_files.log 2>&1

SOURCE_DIR="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation/testout_daily"
DEST_DIR_12KM="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation/testout_daily/12km"
DEST_DIR_4KM="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation/testout_daily/4km"
DEST_DIR_1_33KM="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation/testout_daily/1_33km"


mkdir -p "$DEST_DIR_12KM" "$DEST_DIR_4KM" "$DEST_DIR_1_33KM"

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





