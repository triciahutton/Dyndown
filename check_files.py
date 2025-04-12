import os
import re
import glob
import subprocess
from datetime import datetime, timedelta


PPOUT='/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/post_proc_out/'
PPOUTDATA1_33KM='/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s1991/post_proc_out/1_33km'
PPOUTDATA4KM= '/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s1991/post_proc_out/4km'
PPOUTDATA12KM= '/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-s1991/post_proc_out/12km'

WRFDATA="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/out-s1978"

PPOUTCOMPLETE="/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370/post_proc-s1978"

script_path="/glade/derecho/scratch/phutton/CMIP6/miroc6/ssp370/post_proc-tpl/run_extvar.sh"
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
    if result['WRFout Files'] > 84:
        print('More than 7 days WRFout files detected. you can run update_and_run.sh')
    else:
        print("Less than 7 days WRFout files. Cannot execute post processing.")
    postprocessed_files = os.listdir(PPOUTDATA)
    for file in postprocessed_files:
        entry_path = os.path.join(PPOUTDATA , file)
        if os.path.isfile(entry_path):
            result['PP Files'] += 1
    return result

def check_sequential_dates(data_dir):
    pattern = r'.*_(\d{4})-(\d{2})-(\d{2}).*'
    dates = []
    for file in os.listdir(data_dir):
        match = re.search(pattern, file)
        if match:
            year = match.group(1)
            month = match.group(2)
            day = match.group(3)
            file_date = datetime(year=int(year), month=int(month), day=int(day))
            dates.append(file_date)
    dates.sort()

    for i in range(1, len(dates)):
        expected_date = dates[i-1] + timedelta(days=1)
        if dates[i] != expected_date:
            print(f"Missing date: {expected_date.date()} between {dates[i-1].date()} and {dates[i].date()}")
            return False
    print("All dates are sequential.")
    return True


START_DATE=find_start_date(PPOUT)
print(START_DATE)


file_info= count_files_run_script(WRFDATA,PPOUTDATA1_33KM)
print(file_info)

print('checking in Scratch space for sequential data....')
print('for 1_33km...')
check_sequential_dates(PPOUTDATA1_33KM)
print('for 12km...') 
check_sequential_dates(PPOUTDATA12KM)
print('for 4km...')
check_sequential_dates(PPOUTDATA4KM)

print('checking in campaign space')
print('double check sequential dates... for 12km,1.33km, 4km...')
check_sequential_dates(PPOUTCOMPLETE+'/12km')
check_sequential_dates(PPOUTCOMPLETE+'/1_33km')
check_sequential_dates(PPOUTCOMPLETE+'/4km')
