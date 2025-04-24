import os
from datetime import date

import shutil
from dotenv import load_dotenv

from resources.utils import autoSendMail

class Backupper:
    def __init__(self):
        load_dotenv()
        self.BACK_UP_DIRECTORY_PATH = os.getenv("BACK_UP_DIRECTORY_PATH")
        self.back_up_message = ""
        self.IS_AUTO_SEND_MAIL = os.getenv("IS_AUTO_SEND_MAIL").lower() == "true"
        if self.IS_AUTO_SEND_MAIL:
            self.SENDER_EMAIL = os.getenv("SENDER_EMAIL")
            self.APP_PASSWORD = os.getenv("APP_PASSWORD")
            self.RECEIVER_EMAIL = os.getenv("RECEIVER")

    def back_up(self, file_name, file_path):
        try:
            shutil.copy(file_path+file_name, self.BACK_UP_DIRECTORY_PATH)
            current_date = date.today()
            new_path = f"{self.BACK_UP_DIRECTORY_PATH}/{str(current_date)}-{file_name}"
            shutil.move(f"{self.BACK_UP_DIRECTORY_PATH}/{file_name}", new_path)
            self.back_up_message += " File :"+file_path+file_name+"backup success as "+new_path+"\n"
        except :
            self.back_up_message += " File :"+file_path+file_name+"backup fail"

    def back_ups(self, files, files_path):
        for file in files:
            self.back_up(file, files_path)
        
    def get_file_need_backup(self, folder_path, type_files):
        need_backup_files = []
        file_names = os.listdir(folder_path)
        if len(file_names) == 0 : 
            self.back_up_message = "No such file or directory to backup :"+folder_path
            return None
        
        for file_name in file_names:
            type_file = file_name.split(".")[-1]
            for type in type_files:
                if type == type_file:
                    need_backup_files.append(file_name)
                    break

        if len(need_backup_files) == 0:
            self.back_up_message = "No such file need backup in directory: "+folder_path

        return need_backup_files
    
    def back_up_log(self):
        if self.IS_AUTO_SEND_MAIL:
            if self.SENDER_EMAIL != "" and self.APP_PASSWORD != "" and self.RECEIVER_EMAIL !="": 
                autoSendMail.send_email(    sender=self.SENDER_EMAIL,
                                        subject= "Backup File process",
                                        body=self.back_up_message,
                                        password=self.APP_PASSWORD,
                                        receiver=self.RECEIVER_EMAIL)
        print(self.back_up_message)
