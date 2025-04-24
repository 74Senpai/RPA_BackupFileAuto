# Tự động backup file 
version 1.0.0 

## 1. Chức năng 
- Tự động sao chép dạng file chỉ định từ thư mục này qua thư mục khác 
- Tự động gửi mail thông báo các dữ liệu đã được backup 
- Tự động chạy tại móc thời gian 6 AM hàng ngày 

## 2. Cấu hình 
### Gửi mail 
Tự động gửi mail thông báo log của mỗi lần backup  
- Bật/Tắt gửi mail thông báo :
``` .env
    IS_AUTO_SEND_MAIL = True/False
```
- Cấu hình để gửi mail :
``` .env
APP_PASSWORD = you app password
SENDER_EMAIL = you email 
RECIEVER = receiver email 
```

### Lưu file 
Tự động tìm kiếm, sao chép các file cần backup vào thư mục backup 
- Cấu hình thư mục cần backup:
```.env 
    NEED_BACKUP_FOLDER_PATH = đường đẫn thư mục chứa file cần backup 
```
- Cấu hình thư mục chứa file đã backup:
```.env 
    BACK_UP_DIRECTORY_PATH = đường dẫn thư mục chứa file đã backup 
```

### Backup file 
- Cấu hình file cần backup:
```.env
    TYPE_FILE_NEED_BACKUP = các dạng file cần backup 
```
***Các dạng file cần backup là một chuỗi các đuôi file ngăn cách nhau bởi dấu: *** `|`
Ví dụ: 
```.env
    # Đối với 1 giá trị 
    TYPE_FILE_NEED_BACKUP = "sql" 

    #Đối với nhiều giá trị 
    TYPE_FILE_NEED_BACKUP = "sql|sqlite3|txt|doc" 
```
___ Lưu ý: Phải chứa ít nhất 1 giá trị ___

## 3. Cài đặt 
### Tải code:
```git
    git clone https://github.com/74Senpai/RPA_BackupFileAuto.git
```
### Thư viện:
```cmd 
    pip install -r requirements.txt
```

## 4. Chạy chương trình 
```cmd
    py main.py
```

### Cấu trúc thư mục đề xuất 
    --need_backup
    --backup 
    --resources 
        --backupper
            --backupper.py
        --utils 
            --send_mail_logic.py
            --other_util.py
    --main.py
    --.env
    --README.md
    --requirements.txt 

