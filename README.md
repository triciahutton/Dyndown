# Dyndown
UAF Masters Research, Dynamically Downscaling CMIP6 Models


**extract_vars_pool_tricia.py**-- Post processing script used to extract variables from the wrf out files 

**run_extvar.sh** -- run the script extract_vars_pool_tricia.py with all necessary infputs, as well as logs to log_date_file.log of startdate, AND python log file
**update_and_run.sh** -- reads in date from log_date_file.log, adds 150 days and overwrits run_extvar.sh to new start date to begin processing the next chunk of data 


**move_postproc_out.sh** -- takes all post processed data from the output directory and moves them into 12km 4km and 1.33km folders 

**check_files.py** -- reads each file and counts how many are available to post process from the wrf out file, count how many have already been post processed, and finds the last date in the post processed folder 
**run_check_files.sh** -- runs the python script of check files 





extract_vars.py-- original code from Chris, later adjusted and adapted to fit for CMIP6
