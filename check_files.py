import os
import re
import glob
import subprocess
from datetime import datetime, timedelta

PPOUTDATA= '/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation/testout_daily/1_33km'
WRFDATA="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/out-s1978"
script_path="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/automation/run_extvar.sh"
def find_start_date(data_dir):
    pattern= r'.*_(\d{4})-(\d{2})-(\d{2}).*'
    FOUNDSTARTDATE= None
    latest_date = None
    for file in os.listdir(data_dir):
        if 'wrf_dscale_1_33km' in file:
            match = re.search(pattern, file)
            if match:
                year = match.group(1)
                month = match.group(2)
                day = match.group(3)
                file_date = (year, month, day)
                if latest_date is None or file_date > latest_date:
                    latest_date = file_date
                    FOUNDSTARTDATE = f"{year}{month}{day}"
    return  FOUNDSTARTDATE

def count_files_run_script(WRFDATA,PPOUTDATA):
    result = {
                'WRFout Files': 0,
                'PP Files': 0
            }
    wrfout_files = os.listdir(WRFDATA)
    for file in wrfout_files:
        entry_path = os.path.join(WRFDATA, file)
        if os.path.isfile(entry_path):
            result['WRFout Files'] += 1
    if result['WRFout Files'] > 165:
        print('More than 165 WRFout files detected. you can run  run_extvar.sh, need to update STARTDATE to the date found here')
        #subprocess.run(['./run_extvar.sh'], check = True) #need to make sure the start date is updated thought
    else:
        print("Less than 165 WRFout files. Cannot execute post processing.")
    postprocessed_files = os.listdir(PPOUTDATA)
    for file in postprocessed_files:
        entry_path = os.path.join(PPOUTDATA , file)
        if os.path.isfile(entry_path):
            result['PP Files'] += 1
    return result



START_DATE=find_start_date(PPOUTDATA)
print(START_DATE)


file_info= count_files_run_script(WRFDATA,PPOUTDATA)
print(file_info)

