#!/bin/sh

LOG_FILE="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/log_update_and_run.log"
echo "sarting script" >> "$LOG_FILE"

# Read the START_DATE from the log file
START_DATE=$(grep -oP 'Run Start Date: \K\d{8}' /glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/log_date_file.log)

if [ -z "$START_DATE" ]; then 
	echo "ERROR: START_DATE not found in log_date_file.log"  >> "$LOG_FILE" 
	exit 1
fi

NEW_START_DATE=$(date -d "$START_DATE + 6 days" +%Y%m%d)

echo "Updated START_DATE: $NEW_START_DATE"  >> "$LOG_FILE"

sed -i "s/^START_DATE='.*'/START_DATE='$NEW_START_DATE'/" run_extvar.sh
echo "Changed start date in run_extvar.sh" >> "$LOG_FILE"

echo "Now run run_extvar.sh"  >> "$LOG_FILE"


qsub -V run_extvar.sh 
