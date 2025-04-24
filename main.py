import os
import time

from dotenv import load_dotenv
import schedule

from resources.backupper import backupper

def back_up_task():
    try:
        load_dotenv()
        NEED_BACKUP_FOLDER_PATH = os.getenv("NEED_BACKUP_FOLDER_PATH")
        TYPE_FILE_NEED_BACKUP = os.getenv("TYPE_FILE_NEED_BACKUP").split("|")
        bk = backupper.Backupper()
        bk.back_ups(bk.get_file_need_backup(NEED_BACKUP_FOLDER_PATH, TYPE_FILE_NEED_BACKUP), NEED_BACKUP_FOLDER_PATH)
        bk.back_up_log()
    finally:
        print(" Do backup task done")
    
schedule.every().day.at("00:00").do(back_up_task)

while True:
    schedule.run_pending()
    time.sleep(25)