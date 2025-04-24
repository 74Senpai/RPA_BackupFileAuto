﻿use master
go
if exists(select * from sys.databases where name = 'QLDeAn')
	drop database QLDeAn_MSSV
GO
create database QLDeAn_MSSV
go
use QLDeAn_MSSV
go

CREATE TABLE PHONGBAN
(
	TENPHONG NVARCHAR(30),
	MAPHG INT NOT NULL,
	TRPHG CHAR(9),
	NG_NHANCHUC DATETIME,
	constraint PK_PB PRIMARY KEY (MAPHG)
)
 ALTER TABLE PHONGBAN
  DROP
	constraint PK_PB


CREATE TABLE NHANVIEN
(
	HONV  NVARCHAR(30),
	TENLOT  NVARCHAR(30),
	TEN  NVARCHAR(30),
	MANV CHAR(9) NOT NULL,
	NGSINH DATETIME,
	DCHI NVARCHAR(50),
	PHAI NCHAR(6),
	LUONG FLOAT,
	PHG INT,
	constraint PK_NV PRIMARY KEY(MANV)
)

CREATE TABLE DIADIEM_PHG
(
	MAPHG INT NOT NULL,
	DIADIEM NVARCHAR(30) NOT NULL,
	constraint PK_DD PRIMARY KEY (MAPHG, DIADIEM)
)

CREATE TABLE PHANCONG
(
	MADA INT NOT NULL,
	MA_NVIEN CHAR(9) NOT NULL,
	VITRI NVARCHAR(50),
	constraint PK_PC PRIMARY KEY ( MADA,MA_NVIEN)
)

CREATE TABLE THANNHAN
(
	MA_NVIEN CHAR(9) NOT NULL,
	TENTN NVARCHAR(30) NOT NULL,
	PHAI NCHAR(6),
	NGSINH DATETIME,
	QUANHE NVARCHAR(16),
	constraint PK_TN PRIMARY KEY (MA_NVIEN, TENTN)
)

CREATE TABLE DEAN
(
	TENDA NVARCHAR(30),
	MADA INT NOT NULL,
	DDIEM_DA NVARCHAR(30),
	NGAYBD DATETIME,
	NGAYKT DATETIME,
	constraint PK_DA PRIMARY KEY (MADA)
)
/*TAO KHOA NGOAI CHO CAC BANG*/
/*TRPHG - NHANVIEN(MANV)*/
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_PHONGBAN 
FOREIGN KEY (PHG) REFERENCES PHONGBAN(MAPHG) 

ALTER TABLE PHONGBAN ADD CONSTRAINT FK_PHONGBAN_NHANVIEN
FOREIGN KEY (TRPHG) REFERENCES NHANVIEN(MANV) 


ALTER TABLE DIADIEM_PHG ADD CONSTRAINT FK_DIADIEM_PHG_PHONGBAN
FOREIGN KEY (MAPHG) REFERENCES PHONGBAN(MAPHG)


ALTER TABLE THANNHAN ADD CONSTRAINT FK_THANNHAN_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)


ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)

ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_DEAN
FOREIGN KEY (MADA) REFERENCES DEAN(MADA)

---NHAP DU LIEU BANG PHONG BAN
INSERT INTO PHONGBAN (TENPHONG,MAPHG,TRPHG,NG_NHANCHUC)
VALUES	(N'Phòng Triển Khai',5,NULL,'2010-05-20'),
		(N'Phòng Xây Dựng',4,NULL,'2011-01-01'),
		(N'Phòng Quản Lý',1,NULL,'2012-06-19')
		---NHAP DU LIEU BANG NHAN VIEN
INSERT INTO NHANVIEN(HONV,TENLOT,TEN,MANV,NGSINH,DCHI,PHAI,LUONG,PHG)
Values	(N'Đinh',N'Bá',N'Tiên','123456789','1970-01-09',N'TPHCM',N'Nam',30000,5),
		(N'Nguyễn',N'Thanh',N'Tùng','333445555','1975-12-08',N'TPHCM',N'Nam',40000,5),
		(N'Bùi',N'Thúy',N'Vũ','999887777','1980-07-19',N'Đà Nẵng',N'Nữ',25000,4),
		(N'Lê',N'Thị',N'Nhàn','987654321','1978-06-20',N'Huế',N'Nữ',43000,4),
		(N'Nguyễn',N'Mạnh',N'Hùng','666884444','1984-09-15',N'Quảng Nam',N'Nam',38000,5),
		(N'Trần',N'Thanh',N'Tâm','453453453','1988-07-31',N'Quảng Trị',N'Nam',25000,5),
		(N'Trần',N'Hồng',N'Quân','987987987','1990-03-29',N'Đà Nẵng',N'Nam',25000,4),
		(N'Vương',N'Ngọc',N'Quyền','888665555','1965-10-10',N'Quảng Ngãi',N'Nữ',55000,1)
Go
-----CẬP NHẬT DỮ LIỆU BẢNG PHÒNG BAN
UPDATE PHONGBAN
SET  TRPHG='333445555'
WHERE MAPHG=5
UPDATE PHONGBAN
SET  TRPHG='987987987'
WHERE MAPHG=4
UPDATE PHONGBAN
SET  TRPHG='888665555'
WHERE MAPHG=1
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO DIADIEM_PHG(MAPHG,DIADIEM)
VALUES	(1,N'Đà Nẵng'),
		(4,N'Đà Nẵng'),
		(5,N'Đà Nẵng'),
		(5,N'Hà Nội'),
		(5,N'Quảng Nam')
go
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO THANNHAN(MA_NVIEN,TENTN,PHAI,NGSINH,QUANHE)
values	('333445555',N'Quang',N'Nữ','2005-04-05',N'Con gai'),
		('333445555',N'Khang',N'Nam','2008-10-25',N'Con trai'),
		('333445555',N'Duong',N'Nữ','2078-05-03',N'Vo chong'),
		('987654321',N'Dang',N'Nam','2070-02-20',N'Vo chong'),
		('123456789',N'Duy',N'Nam','2000-01-01',N'Con trai'),
		('123456789',N'Chau',N'Nữ','2004-12-31',N'Con gai'),
		('123456789',N'Phuong',N'Nữ','2077-05-05',N'Vo chong')
Go
---NHAP DU LIEU BANG DEAN
INSERT INTO DEAN(TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values	(N'Quản Lí Khách Sạn',100,N'Đà Nẵng','2012-01-01','2012-02-20'),
		(N'Quản Lí Bệnh Viện',200,N'Đà Nẵng','2013-03-15','2013-06-30'),
		(N'Quản Lí Bán Hàng',300,N'Hà Nội','2013-12-01','2014-02-01'),
		(N'Quản Lí Đào Tạo',400,N'Hà Nội','2014-03-15',null)
Go
---NHAP DU LIEU BANG PHAN CONG
INSERT INTO PHANCONG(MADA,MA_NVIEN,VITRI)
values	(100,'333445555',N'Trưởng Nhóm'),
		(100,'123456789',N'Thành Viên'),
		(100,'666884444',N'Thành Viên'),
		(200,'987987987',N'Trưởng Dự Án'),
		(200,'999887777',N'Trưởng Nhóm'),
		(200,'453453453',N'Thành Viên'),
		(200,'987654321',N'Thành Viên'),
		(300,'987987987',N'Trưởng Dự Án'),
		(300,'999887777',N'Trưởng Nhóm'),
		(300,'333445555',N'Trưởng Nhóm'),
		(300,'666884444',N'Thành Viên'),
		(300,'123456789',N'Thành Viên'),
		(400,'987987987',N'Trưởng Dự Án'),
		(400,'999887777',N'Trưởng Nhóm'),
		(400,'123456789',N'Thành Viên'),
		(400,'333445555',N'Thành Viên'),
		(400,'987654321',N'Thành Viên'),
		(400,'666884444',N'Thành Viên')
Go



SELECT  PHONGBAN.TENPHONG, COUNT(NHANVIEN.PHG)
	FROM NHANVIEN
		inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
	GROUP BY PHONGBAN.TENPHONG
	
	

/*
1. Các lệnh truy vấn đơn
a. Cho biết danh sách các nhân viên thuộc phòng triển khai.
b. Cho biết họ tên trưởng phòng của phòng quản lý
c. Cho biết họ tên những trưởng phòng tham gia đề án ở “Hà Nội”
d. Cho biết họ tên nhân viên có thân nhân.
e. Cho biết họ tên nhân viên được phân công tham gia đề án.
f. Cho biết mã nhân viên (MA_NVIEN) có người thân và tham gia đề án.
g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.
h. Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.
i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có
j. Danh sách những đề án có:
o Người tham gia có họ “Đinh”
o Có người trưởng phòng chủ trì đề án họ “Đinh”
2. Các lệnh truy vấn lồng
k. Viết lại tất cả các câu trên thành các câu SELECT lồng.
l. Cho biết những nhân viên có cùng tên với người thân
m. Cho biết danh sách những nhân viên có 2 thân nhân trở lên
n. Cho biết những trưởng phòng có tối thiểu 1 thân nhân
o. Cho biết những trưởng phòng có mức lương ít hơn (ít nhất một) nhân viên của mình
3.Các lệnh về gom nhóm
p. Cho biết tên phòng, mức lương trung bình của phòng đó >40000.
q. Cho biết lương trung bình của tất các nhân viên nữ phòng số 4
r. Cho biết họ tên và số thân nhân của nhân viên phòng số 5 có trên 2 thân nhân
s. Ứng với mỗi phòng cho biết họ tên nhân viên có mức lương cao nhất
t. Cho biết họ tên nhân viên nam và số lượng các đề án mà nhân viên đó tham gia
u. Cho biết nhân viên (HONV, TENLOT, TENNV) nào có lương cao nhất.
v. Cho biết mã nhân viên (MA_NVIEN) nào có nhiều thân nhân nhất.
w. Cho biết họ tên trưởng phòng của phòng có đông nhân viên nhất
x. Đếm số nhân viên nữ của từng phòng, hiển thị: TenPHG, SoNVNữ, những khoa không có nhân viên nữ hiển thị SoNVNữ=0
4. VIEW
a. Cho biết tên phòng, số lượng nhân viên và mức lương trung bình của từng phòng.
b. Cho biết họ tên nhân viên và số lượng các đề án mà nhân viên đó tham gia
c. Thống kê số nhân viên của từng phòng, hiển thị: MaPH, TenPHG, SoNVNữ, SoNVNam, TongSoNV. */

--1
--a. Cho biết danh sách các nhân viên thuộc phòng triển khai.
SELECT * 
	FROM NHANVIEN
		inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
	WHERE PHONGBAN.TENPHONG = N'Phòng Triển Khai'
GO

--b. Cho biết họ tên trưởng phòng của phòng quản lý

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN, hoVaTen = (NHANVIEN.HONV + NHANVIEN.TENLOT + NHANVIEN.TEN)
	FROM PHONGBAN
		inner join NHANVIEN on NHANVIEN.MANV = PHONGBAN.TRPHG	
	WHERE PHONGBAN.TENPHONG = N'Phòng Quản Lý'
GO

-- c. Cho biết họ tên những trưởng phòng tham gia đề án ở “Hà Nội”

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
	FROM PHANCONG
		inner join PHONGBAN on PHONGBAN.TRPHG = PHANCONG.MA_NVIEN
		inner join DEAN on DEAN.MADA = PHANCONG.MADA
		inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	WHERE DEAN.DDIEM_DA = N'Hà Nội'
	GROUP BY NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
GO

--d. Cho biết họ tên nhân viên có thân nhân.

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
	FROM THANNHAN
		inner join NHANVIEN on NHANVIEN.MANV = THANNHAN.MA_NVIEN
	GROUP BY NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
GO

--e. Cho biết họ tên nhân viên được phân công tham gia đề án.

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
	FROM PHANCONG
		inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	GROUP BY NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
GO

--f. Cho biết mã nhân viên (MA_NVIEN) có người thân và tham gia đề án.

SELECT PHANCONG.MA_NVIEN
	FROM PHANCONG
		inner join THANNHAN on THANNHAN.MA_NVIEN = PHANCONG.MA_NVIEN
	GROUP BY PHANCONG.MA_NVIEN
GO

--g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.

SELECT cacDeAnCoHoNguyen=(PHANCONG.MADA)
	FROM PHANCONG
		inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	WHERE NHANVIEN.HONV = N'Nguyễn'
	GROUP BY PHANCONG.MADA
GO

--Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.

SELECT DEAN.TENDA
	FROM PHANCONG
		inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
		inner join DEAN on DEAN.MADA = PHANCONG.MADA
		inner join PHONGBAN on PHONGBAN.TRPHG = PHANCONG.MA_NVIEN
	WHERE NHANVIEN.HONV = N'Nguyễn' AND PHANCONG.VITRI = N'Trưởng Nhóm'
	GROUP BY  DEAN.TENDA
GO

--i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có

SELECT NHANVIEN.TEN, PHONGBAN.TENPHONG
	FROM NHANVIEN
		inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
GO

/*j. Danh sách những đề án có:
o Người tham gia có họ “Đinh”
o Có người trưởng phòng chủ trì đề án họ “Đinh”-*/

SELECT DEAN.MADA
	FROM PHANCONG
		inner join DEAN on DEAN.MADA = PHANCONG.MADA
		inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	WHERE NHANVIEN.HONV = N'Đinh'
	GROUP By DEAN.MADA
GO

SELECT PHANCONG.MADA
	FROM PHANCONG
		inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
		inner join PHONGBAN on PHONGBAN.TRPHG = PHANCONG.MA_NVIEN
	WHERE NHANVIEN.HONV = N'Đinh' AND PHANCONG.VITRI = N'Trưởng Phòng Chủ Trì'
	GROUP By  PHANCONG.MADA
GO

--2. Các lệnh truy vấn lồng
--k. Viết lại tất cả các câu trên thành các câu SELECT lồng.
--a. Cho biết danh sách các nhân viên thuộc phòng triển khai.
SELECT * 
	FROM NHANVIEN
	WHERE NHANVIEN.PHG = (SELECT PHONGBAN.MAPHG 
								FROM PHONGBAN 
								WHERE PHONGBAN.TENPHONG = N'Phòng Triển Khai' )
GO

--b. Cho biết họ tên trưởng phòng của phòng quản lý

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN, hoVaTen = (NHANVIEN.HONV + NHANVIEN.TENLOT + NHANVIEN.TEN)
	FROM NHANVIEN
	WHERE NHANVIEN.MANV = ( SELECT PHONGBAN.TRPHG 
								FROM PHONGBAN
								WHERE PHONGBAN.TENPHONG = N'Phòng Quản Lý')
GO

-- c. Cho biết họ tên những trưởng phòng tham gia đề án ở “Hà Nội”

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
	FROM NHANVIEN
		
	WHERE NHANVIEN.MANV IN (SELECT PHONGBAN.TRPHG
								FROM PHONGBAN
								WHERE PHONGBAN.TRPHG IN (SELECT PHANCONG.MA_NVIEN
															FROM PHANCONG
															WHERE PHANCONG.MADA IN (SELECT DEAN.MADA
																						FROM DEAN
																						WHERE DEAN.DDIEM_DA = N'Hà Nội')))
GO

--d. Cho biết họ tên nhân viên có thân nhân.

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
	FROM NHANVIEN
	WHERE NHANVIEN.MANV IN ( SELECT THANNHAN.MA_NVIEN 
								FROM THANNHAN)
GO

--e. Cho biết họ tên nhân viên được phân công tham gia đề án.

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
	FROM NHANVIEN
	WHERE NHANVIEN.MANV IN (SELECT PHANCONG.MA_NVIEN 
								FROM PHANCONG)
GO

--f. Cho biết mã nhân viên (MA_NVIEN) có người thân và tham gia đề án.

SELECT PHANCONG.MA_NVIEN
	FROM PHANCONG
	WHERE PHANCONG.MA_NVIEN IN (SELECT THANNHAN.MA_NVIEN 
									FROM THANNHAN)
	GROUP BY PHANCONG.MA_NVIEN
GO

--g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.

SELECT cacDeAnCoHoNguyen=(PHANCONG.MADA)
	FROM PHANCONG
		
	WHERE PHANCONG.MA_NVIEN IN (SELECT NHANVIEN.MANV
									FROM NHANVIEN
									WHERE NHANVIEN.HONV = N'Nguyễn')
	GROUP BY PHANCONG.MADA
GO

--Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.

SELECT DEAN.TENDA
	FROM DEAN
	WHERE DEAN.MADA IN (SELECT PHANCONG.MADA 
							FROM PHANCONG
							WHERE PHANCONG.VITRI = N'Trưởng Nhóm' 
								AND PHANCONG.MA_NVIEN IN (SELECT NHANVIEN.MANV 
															FROM NHANVIEN
															WHERE NHANVIEN.HONV = N'Nguyễn' 
																AND NHANVIEN.MANV IN (SELECT PHONGBAN.TRPHG
																						FROM PHONGBAN)))
	GROUP BY  DEAN.TENDA
GO

--i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có

SELECT NHANVIEN.TEN, TenPhongBan = (SELECT PHONGBAN.TENPHONG
										FROM PHONGBAN
										WHERE PHONGBAN.MAPHG = NHANVIEN.PHG)
	FROM NHANVIEN
GO

/*j. Danh sách những đề án có:
o Người tham gia có họ “Đinh”
o Có người trưởng phòng chủ trì đề án họ “Đinh”-*/

SELECT DEAN.MADA
	FROM DEAN
	WHERE DEAN.MADA IN (SELECT PHANCONG.MADA 
							FROM PHANCONG
							WHERE PHANCONG.MA_NVIEN IN (SELECT NHANVIEN.MANV
															FROM NHANVIEN
															WHERE NHANVIEN.HONV = N'Đinh'))
	
GO

SELECT DEAN.MADA
	FROM DEAN
	WHERE DEAN.MADA IN (SELECT PHANCONG.MADA 
							FROM PHANCONG
							WHERE PHANCONG.VITRI = N'Trưởng Nhóm'
								AND  PHANCONG.MA_NVIEN IN (SELECT NHANVIEN.MANV
																FROM NHANVIEN
																WHERE NHANVIEN.HONV = N'Đinh'
																	AND NHANVIEN.MANV IN (SELECT PHONGBAN.TRPHG
																							FROM PHONGBAN)))
	
GO

--l. Cho biết những nhân viên có cùng tên với người thân

SELECT THANNHAN.MA_NVIEN
	FROM THANNHAN
	WHERE THANNHAN.TENTN IN (SELECT NHANVIEN.TEN
								FROM NHANVIEN)
	GROUP BY THANNHAN.MA_NVIEN
GO

--m. Cho biết danh sách những nhân viên có 2 thân nhân trở lên
SELECT * 
	FROM NHANVIEN
	WHERE NHANVIEN.MANV IN (SELECT THANNHAN.MA_NVIEN
								FROM THANNHAN
								GROUP BY THANNHAN.MA_NVIEN
								HAVING COUNT(THANNHAN.MA_NVIEN) >= 2 )
GO
	
--n. Cho biết những trưởng phòng có tối thiểu 1 thân nhân

SELECT *
	FROM NHANVIEN
	WHERE NHANVIEN.MANV IN (SELECT THANNHAN.MA_NVIEN
								FROM THANNHAN
								GROUP BY THANNHAN.MA_NVIEN
								HAVING COUNT(THANNHAN.MA_NVIEN) >= 1 )
		AND NHANVIEN.MANV IN (SELECT PHONGBAN.TRPHG
								FROM PHONGBAN)
GO

--o. Cho biết những trưởng phòng có mức lương ít hơn (ít nhất một) nhân viên của mình

SELECT *
FROM NHANVIEN AS NV1
WHERE NV1.LUONG < (SELECT MAX(NV2.LUONG)
                    FROM NHANVIEN AS NV2
                    WHERE NV2.PHG = NV1.PHG)
  AND NV1.MANV IN (SELECT PHONGBAN.TRPHG
                    FROM PHONGBAN)


--SELECT NHANVIEN.PHG, NHANVIEN.MANV
--	FROM NHANVIEN
--	WHERE NHANVIEN.LUONG < (SELECT MAX(NHANVIEN.LUONG) 
--									FROM NHANVIEN
--									WHERE NHANVIEN.PHG IN(SELECT NHANVIEN.PHG, NHANVIEN.MANV
--															FROM NHANVIEN
--															WHERE NHANVIEN.MANV IN (SELECT PHONGBAN.TRPHG
--																					FROM PHONGBAN
--																					WHERE PHONGBAN.TRPHG = NHANVIEN.MANV)))


--3.Các lệnh về gom nhóm
-- p. Cho biết tên phòng, mức lương trung bình của phòng đó >40000.

SELECT PHONGBAN.TENPHONG, MucLuongTB = (SELECT AVG(NHANVIEN.LUONG) 
											FROM NHANVIEN
											WHERE NHANVIEN.PHG = PHONGBAN.MAPHG)
	FROM PHONGBAN
GO

--q. Cho biết lương trung bình của tất các nhân viên nữ phòng số 4

SELECT PHONGBAN.TENPHONG, MucLuongTB = (SELECT AVG(NHANVIEN.LUONG) 
											FROM NHANVIEN
											WHERE NHANVIEN.PHAI = N'Nữ' AND NHANVIEN.PHG = PHONGBAN.MAPHG )
	FROM PHONGBAN
	WHERE PHONGBAN.MAPHG = 4
GO

--r. Cho biết họ tên và số thân nhân của nhân viên phòng số 5 có trên 2 thân nhân

SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN, soThanNhan = (SELECT COUNT(*)
																	 FROM THANNHAN
																	 WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV)
	FROM NHANVIEN
	WHERE NHANVIEN.PHG = 5
	  AND (SELECT COUNT(*)
		   FROM THANNHAN
		   WHERE THANNHAN.MA_NVIEN = NHANVIEN.MANV) > 2
GO

--Ứng với mỗi phòng cho biết họ tên nhân viên có mức lương cao nhất
SELECT PHONGBAN.TENPHONG, MucLuongCaoNhat = (SELECT TOP 1 NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TEN
												  FROM NHANVIEN
												  WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
												  ORDER BY NHANVIEN.LUONG DESC)
	FROM PHONGBAN
GO

-- Cho biết họ tên nhân viên nam và số lượng các đề án mà nhân viên đó tham gia
SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN, soLuongDeAn = (SELECT COUNT(PHANCONG.MADA)
																		FROM PHANCONG
																		WHERE PHANCONG.MA_NVIEN = NHANVIEN.MANV)
	FROM NHANVIEN
GO

-- Cho biết nhân viên (HONV, TENLOT, TENNV) nào có lương cao nhất.
SELECT TOP 1 NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN
	FROM NHANVIEN
	ORDER BY NHANVIEN.LUONG DESC
GO

-- v. Cho biết mã nhân viên (MA_NVIEN) nào có nhiều thân nhân nhất.
SELECT TOP 1 MA_NVIEN
	FROM THANNHAN
	GROUP BY MA_NVIEN
	ORDER BY COUNT(*) DESC
GO

--w. Cho biết họ tên trưởng phòng của phòng có đông nhân viên nhất

SELECT TOP 1 NHANVIEN.HONV , NHANVIEN.TENLOT , NHANVIEN.TEN , COUNT(NHANVIEN.MANV)
	FROM NHANVIEN
	inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	WHERE PHANCONG.VITRI = N'Trưởng Nhóm'
	GROUP BY NHANVIEN.HONV , NHANVIEN.TENLOT , NHANVIEN.TEN
GO
--x. Đếm số nhân viên nữ của từng phòng, hiển thị: TenPHG, SoNVNữ, những khoa không có nhân viên nữ hiển thị SoNVNữ=0
SELECT PHONGBAN.TENPHONG, COUNT(NHANVIEN.MANV) 
	FROM PHONGBAN
	LEFT JOIN NHANVIEN ON PHONGBAN.MAPHG = NHANVIEN.PHG AND NHANVIEN.PHAI = N'Nữ'
	GROUP BY PHONGBAN.TENPHONG
GO
--4. VIEW
--a. Cho biết tên phòng, số lượng nhân viên và mức lương trung bình của từng phòng.
SELECT PHONGBAN.TENPHONG , COUNT(NHANVIEN.MANV) as so_nhan_vien , AVG(NHANVIEN.LUONG)
	FROM PHONGBAN
	inner join NHANVIEN on PHONGBAN.MAPHG = NHANVIEN.PHG
	GROUP BY PHONGBAN.TENPHONG
GO
--b. Cho biết họ tên nhân viên và số lượng các đề án mà nhân viên đó tham gia
SELECT NHANVIEN.HONV , NHANVIEN.TENLOT , NHANVIEN.TEN , COUNT(PHANCONG.MADA)
	FROM NHANVIEN
		inner join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
	GROUP BY NHANVIEN.HONV , NHANVIEN.TENLOT , NHANVIEN.TEN
GO
--c. Thống kê số nhân viên của từng phòng, hiển thị: MaPH, TenPHG, SoNVNữ, SoNVNam, TongSoNV.
SELECT PHONGBAN.MAPHG, PHONGBAN.TENPHONG,
       SUM(CASE WHEN NHANVIEN.PHAI = N'Nữ' THEN 1 ELSE 0 END) AS SoNVNu,
       SUM(CASE WHEN NHANVIEN.PHAI = N'Nam' THEN 1 ELSE 0 END) AS SoNVNam,
       COUNT(NHANVIEN.MANV) AS TongSoNV
	FROM PHONGBAN 
		LEFT JOIN NHANVIEN  ON PHONGBAN.MAPHG = NHANVIEN.PHG
	GROUP BY PHONGBAN.MAPHG, PHONGBAN.TENPHONG
GO

------------------------ Hom nay la thu 7 

-----a. Công ty quyết định tăng lương cho nhân viên như sau: 
--+ 20% nếu tham gia ít nhất 2 dự án với chức vụ trưởng dự án
-- + 15% nếu là trưởng phòng hoặc người quản lý trực tiếp 
--+ 10% nếu là nhân viên phòng số 5 có tham gia dự án bắt đầu và kết thúc trong năm
--2014 .

--- B1: tinh so du an nv tham gia
--- Khai bao
DECLARE cur_tangLuong CURSOR 
	FORWARD_ONLY
	FOR 
		SELECT NHANVIEN.MANV, NHANVIEN.PHG  FROM NHANVIEN 

--- mo 
OPEN cur_tangLuong
--- 

DECLARE @maNV char(9), @Phong int
fetch next from cur_tangLuong into @maNV, @Phong
WHILE(@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @heSoTang int = 0
		set @heSoTang += CASE 
							WHEN ((SELECT COUNT(*) FROM PHANCONG WHERE MA_NVIEN = @maNV AND PHANCONG.VITRI = N'Trưởng Dự Án') = 2) THEN 20 ELSE @heSoTang
						 END 
						
		set @heSoTang += CASE 	
							WHEN @maNV IN (SELECT PHONGBAN.TRPHG FROM PHONGBAN) THEN 15 ELSE @heSoTang
						 END		
		set @heSoTang += CASE 
							WHEN EXISTS (SELECT DISTINCT PHANCONG.MA_NVIEN FROM PHANCONG
														inner join DEAN on DEAN.MADA = PHANCONG.MADA
													WHERE YEAR(NGAYBD) = 2014 AND YEAR(NGAYKT) = 2014 AND PHANCONG.MA_NVIEN = @maNV ) AND @Phong = 5 
							THEN 10
							ELSE @heSoTang
						 END

		--PRINT CAST(@heSoTang as char) + 'MNV' + @maNV
		UPDATE NHANVIEN
			SET NHANVIEN.LUONG = LUONG + (LUONG * (@heSoTang/100))
			WHERE MANV = @maNV

		fetch next from cur_tangLuong into @maNV , @Phong
	END

CLOSE cur_tangLuong --- Dongss
DEALLOCATE cur_tangLuong --- Xoa
GO

SELECT * FROM NHANVIEN

-- Ứng với mỗi đề án, thêm mới 3 cột: số lượng trưởng dự án, số lượng trưởng nhóm,
--số lượng thành viên. 
--Dùng con trỏ duyệt qua từng dòng trong bảng DEAN cập nhật dữ liệu
--cho 3 cột này.

ALTER TABLE DEAN
	ADD
		SLTruongDA int,
		SLTruongNhom int,
		SLThanhVien int
GO
SELECT * FROM DEAN
GO
-------
DECLARE cur_DeAn CURSOR
	FORWARD_ONLY
FOR SELECT DEAN.MADA FROM DEAN

OPEN cur_DeAn

DECLARE @maDA int

fetch next FROM cur_DeAn into @maDA
WHILE(@@FETCH_STATUS = 0)
	BEGIN 
		DECLARE @soTruongDA int = 0, @soTruongNhom int = 0 , @soThanhVien int = 0

		SET @soTruongNhom = (SELECT COUNT(*) FROM PHANCONG WHERE MADA = @maDA AND VITRI = N'Trưởng Nhóm')

		SET @soTruongDA = (SELECT COUNT(*) FROM PHANCONG WHERE MADA = @maDA AND VITRI = N'Trưởng Dự Án')

		SET @soThanhVien = (SELECT COUNT(PHANCONG.MA_NVIEN) FROM PHANCONG WHERE  MADA = @maDA)

		UPDATE DEAN
			 SET SLTruongDA = @soTruongDA,
				SLTruongNhom = @soTruongNhom,
				SLThanhVien = @soThanhVien
		WHERE MADA = @maDA

		fetch next FROM cur_DeAn into @maDA
		
	END

CLOSE cur_DeAn
DEALLOCATE cur_DeAn
GO

SELECT * FROM DEAN

--------------- LAB 7

--Viết các PROCEDURE sau: 
--a. Tạo thủ tục hiển thị nhân viên (họ tên) tham gia nhiều dự án nhất trong năm 2013 
--b. Tạo thủ tục hiển thị tên dự án, trưởng dự án và số nhân viên tham gia dự án đó. 
--c. Tạo thủ tục truyền vào mã dự án, hiển thị tất cả các nhân viên tham gia dự án đó. 
--d. Tạo thủ tục truyền vào mã phòng ban, hiển thị tên phòng ban, số lượng nhân viên và số lượng địa điểm của phòng ban đó. 
--e. Tạo thủ tục truyền vào mã nhân viên (@manv) và vị trí (@vitri), hiển thị tên những dự án mà @manv tham gia với vị trí là @vitri. 
--f. Tạo thủ tục: 
	--o Tham số vào: @mapb 
	--o Tham số ra: @luongcaonhat, @tennhanvien: lương cao nhất của phòng ban đó và họ tên nhân viên đạt lương cao nhất đó. 
--g. Tạo thủ tục: 
	--o Tham số vào: @ngaybatdau, @ngayketthuc 
	--o Tham số ra: @soduan: số lượng dự án bắt đầu và kết thúc trong khoảng thời gian trên (có nghĩa sau bắt đầu sau @ ngaybatdau và kết thúc trước @ngayketthuc) 
--h. Tạo thủ tục: 
	--o Tham số vào: @mada 
	--o Tham số ra: @sonu, @sonam: số nhân viên nữ và nhân viên nam tham gia dự án đó. 
--i. Tạo thủ tục thêm mới một phòng ban với các tham số vào: @mapb, @tenpb, @trphg, @ngnhanchuc. 
	--Yêu cầu: 
	--o Kiểm tra @mapb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục. 
	--o Kiểm tra @tenpb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục. 
	--o Kiểm tra @trphg có phải là nhân viên không, nếu không phải là nhân viên thì thông báo và kết thúc thủ tục. 
	--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phòng ban. 
--j. Tạo thủ tục cập nhật ngày kết thúc của một dự án với tham số vào là @mada và @ngayketthuc. 
	--Yêu cầu: 
	--o Kiểm tra @mada có tồn tại không, nếu không thì thông báo và kết thúc thủ tục. 
	--o Kiểm tra @ngayketthuc có sau ngày bắt đầu không, nếu không thì thông báo và kết thúc thủ tục 
	--o Nếu các điều kiện trên đều thỏa thì cho cập nhật ngày kết thúc. 
--k. Tạo thủ tục phân công nhân viên vào dự án mới. Các tham số vào là: @mada, @manv, @vitri. 
	--Yêu cầu: 
	--o @vitri chỉ nhận một trong 3 giá trị: “Trưởng dự án”, “Trưởng nhóm” và “Thành viên”. Nếu không thỏa điều kiện này thì thông báo và kết thúc thủ tục. 
	--o Nếu @vitri = “Trưởng dự án” thì kiểm tra dự án @duan đã có nhân viên làm “Trưởng dự án” chưa, nếu có rồi thì thông báo và kết thúc thủ tục. 
	--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phân công.

	--------

--a. Tạo thủ tục hiển thị nhân viên (họ tên) tham gia nhiều dự án nhất trong năm 2013 

ALTER PROC usp_NV_KhoNhat
AS 
BEGIN 
	DECLARE @top int = 0
	SET @top = (SELECT TOP 1 COUNT(PHANCONG.MA_NVIEN) as SoDA 
					FROM PHANCONG 
						inner join DEAN on DEAN.MADA = PHANCONG.MADA
					WHERE YEAR(DEAN.NGAYBD) = 2013
				GROUP BY MA_NVIEN 
				ORDER BY SoDA DESC) 

	SELECT NHANVIEN.HONV, NHANVIEN.TENLOT, NHANVIEN.TEN 
		FROM NHANVIEN
			
		WHERE NHANVIEN.MANV in (SELECT PHANCONG.MA_NVIEN
									FROM PHANCONG
								GROUP BY PHANCONG.MA_NVIEN
								HAVING COUNT(PHANCONG.MA_NVIEN) = @top)

END
----
EXEC usp_NV_KhoNhat

----
--b. Tạo thủ tục hiển thị tên dự án, trưởng dự án và số nhân viên tham gia dự án đó.

CREATE PROC usp_ChiTietDA
AS
BEGIN 
	
	SELECT 
		DEAN.TENDA, 
		DEAN.SLThanhVien, 
		CASE 
			WHEN PHANCONG.VITRI = N'Trưởng dự án' THEN (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TEN) 
			ELSE 'Ko co ai' 
		END AS HoTen_TruongDA
	FROM DEAN
		left join PHANCONG ON PHANCONG.MADA = DEAN.MADA AND PHANCONG.VITRI = N'Trưởng dự án'
		left join NHANVIEN ON NHANVIEN.MANV = PHANCONG.MA_NVIEN

END 

EXEC usp_ChiTietDA
-----
--c. Tạo thủ tục truyền vào mã dự án, hiển thị tất cả các nhân viên tham gia dự án đó.

ALTER PROC usp_NhanVienDA
	@maDA int
AS
BEGIN 
	IF(@maDA = '' OR @maDA is NULL) RETURN
	SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TEN) as HoTen
		FROM PHANCONG
			inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
		WHERE PHANCONG.MADA = @maDA
END

DECLARE @maDA int = 400
EXEC usp_NhanVienDA @maDA
------
--d. Tạo thủ tục truyền vào mã phòng ban, hiển thị tên phòng ban, số lượng nhân viên và số lượng địa điểm của phòng ban đó. 
CREATE PROC usp_PhongBan
	@maPB int
AS 
BEGIN 
	IF(@maPB is NULL) RETURN

	DECLARE @soNV int, @soDD int;

	SELECT @soNV = COUNT(MANV)
	FROM NHANVIEN
	WHERE PHG = @maPB

	SELECT @soDD = COUNT(DIADIEM)
	FROM DIADIEM_PHG
	WHERE MAPHG = @maPB

	SELECT 
		PHONGBAN.TENPHONG, 
		@soNV AS SoNV, 
		@soDD AS SoDD
	FROM 
		PHONGBAN
	WHERE 
		PHONGBAN.MAPHG = @maPB

END
----

EXEC usp_PhongBan 5
-----
--e. Tạo thủ tục truyền vào mã nhân viên (@manv) và vị trí (@vitri), hiển thị tên những dự án mà @manv tham gia với vị trí là @vitri. 
CREATE PROC usp_NhanVien_DA
	@maNV char(9), @viTri nvarchar(50)
AS
BEGIN 
	SELECT DEAN.TENDA
		FROM PHANCONG
			inner join DEAN on DEAN.MADA = PHANCONG.MADA
	WHERE PHANCONG.MA_NVIEN = @maNV AND  PHANCONG.VITRI = @viTri
END

-------------
--f. Tạo thủ tục: 
	--o Tham số vào: @mapb 
	--o Tham số ra: @luongcaonhat, @tennhanvien: lương cao nhất của phòng ban đó và họ tên nhân viên đạt lương cao nhất đó.
CREATE PROC usp_LuongCaoNhat
	@maPB int, 
	@tenNV nvarchar(50) output,
	@luongCaoNhat int output
AS 
BEGIN
	IF(@maPB is NULL) RETURN 

	SELECT TOP 1 @tenNV = (NHANVIEN.HONV+''+NHANVIEN.TENLOT+''+NHANVIEN.TEN),@luongCaoNhat = NHANVIEN.LUONG
		FROM NHANVIEN
	WHERE NHANVIEN.PHG = @maPB
	ORDER BY NHANVIEN.LUONG DESC
END
----
DECLARE @tenNV nvarchar(50), @maPB int , @mucLuong int
EXEC usp_LuongCaoNhat 5, @tenNV OUTPUT, @mucLuong OUTPUT
PRINT 'Ten:'+@tenNV+' muc luong: '+ CAST(@mucLuong as char(20))
---------
--g. Tạo thủ tục: 
	--o Tham số vào: @ngaybatdau, @ngayketthuc 
	--o Tham số ra: @soduan: số lượng dự án bắt đầu và kết thúc trong khoảng thời gian trên (có nghĩa sau bắt đầu sau @ ngaybatdau và kết thúc trước @ngayketthuc) 
SET DATEFORMAT dmy
CREATE PROC usp_DuAnInTime
	@ngayBD date, 
	@ngayKT date,
	@soDA int output
AS
BEGIN
	SELECT @soDA = COUNT(*) 
		FROM DEAN
	WHERE DEAN.NGAYBD > @ngayBD AND DEAN.NGAYKT < @ngayKT
END
---
DECLARE @ngayBD date, @ngayKT date, @soDa int
EXEC usp_DuAnInTime @ngayBD, @ngayKT, @soDa OUTPUT
-----
--h. Tạo thủ tục: 
	--o Tham số vào: @mada 
	--o Tham số ra: @sonu, @sonam: số nhân viên nữ và nhân viên nam tham gia dự án đó. 
CREATE PROC usp_NVDA
	@maDA int,
	@soNu int output,
	@soNam int output
AS
BEGIN
	IF(@maDA is NULL) RETURN
	SELECT @soNu = COUNT(*) 
		FROM PHANCONG 
			inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
		WHERE PHANCONG.MADA = @maDA AND NHANVIEN.PHAI = N'Nữ'

	SELECT @soNam = COUNT(*) 
		FROM PHANCONG 
			inner join NHANVIEN on NHANVIEN.MANV = PHANCONG.MA_NVIEN
		WHERE PHANCONG.MADA = @maDA AND NHANVIEN.PHAI = N'Nam'
END

DECLARE @soNam int, @soNu int
EXEC usp_NVDA 400, @soNu OUTPUT, @soNam OUTPUT
PRINT CAST(@soNam as varchar(3)) + '|||' + CAST(@soNu as varchar(3))
----------------
--i. Tạo thủ tục thêm mới một phòng ban với các tham số vào: @mapb, @tenpb, @trphg, @ngnhanchuc. 
	--Yêu cầu: 
	--o Kiểm tra @mapb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục. 
	--o Kiểm tra @tenpb có tồn tại không, nếu tồn tại rồi thì thông báo và kết thúc thủ tục. 
	--o Kiểm tra @trphg có phải là nhân viên không, nếu không phải là nhân viên thì thông báo và kết thúc thủ tục. 
	--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phòng ban. 

CREATE PROC usp_ThemPhongBan
	@maPB int,
	@tenPB nvarchar(50),
	@trPHG char(9), 
	@ngayNC datetime
AS
BEGIN
	IF EXISTS(SELECT * FROM PHONGBAN WHERE MAPHG = @maPB) OR @maPB is NULL
		BEGIN
			PRINT 'PHONG BAN DA TON TAI (OR NULL INDEX)'
			RETURN
		END
	IF EXISTS(SELECT * FROM PHONGBAN WHERE TENPHONG = @tenPB) OR @tenPB is NULL
		BEGIN
			PRINT 'TEN PHONG BAN DA TON TAI (OR NULL INDEX)'
			RETURN
		END
	IF NOT EXISTS(SELECT * FROM NHANVIEN WHERE MANV = @trPHG) OR @trPHG is NULL
		BEGIN
			PRINT 'KHONG TON TAI NV NAY (OR NULL INDEX)'
			RETURN
		END

	BEGIN TRY
		INSERT INTO PHONGBAN(MAPHG, TENPHONG, TRPHG, NG_NHANCHUC)
			VALUES (@maPB, @tenPB, @trPHG, @ngayNC)
	END TRY
	BEGIN CATCH
		PRINT 'THEM MOI KHONG THANH CONG'
		RETURN
	END CATCH

	PRINT 'THEM MOI THANH CONG'
	
END

DECLARE @maPB int = '7', @tenPB nvarchar(50) = N'TEST ADD', @trPHG char(9) = '123456789', @ngayNC datetime = GETDATE();
EXEC  usp_ThemPhongBan @maPB, @tenPB, @trPHG, @ngayNC

SELECT * FROM PHONGBAN
----------------
--j. Tạo thủ tục cập nhật ngày kết thúc của một dự án với tham số vào là @mada và @ngayketthuc. 
	--Yêu cầu: 
	--o Kiểm tra @mada có tồn tại không, nếu không thì thông báo và kết thúc thủ tục. 
	--o Kiểm tra @ngayketthuc có sau ngày bắt đầu không, nếu không thì thông báo và kết thúc thủ tục 
	--o Nếu các điều kiện trên đều thỏa thì cho cập nhật ngày kết thúc. 
CREATE PROC usp_UpdateDayEnd
	@maDA int,
	@ngayKT datetime
AS
BEGIN 
	IF NOT EXISTS (SELECT * FROM DEAN WHERE MADA = @maDA) OR  @maDA is NULL
		BEGIN
			PRINT 'MA DE AN KHONG TON TAI'
			RETURN
		END
	IF ( (@ngayKT <= (SELECT DISTINCT NGAYBD FROM DEAN WHERE DEAN.MADA = @maDA)) OR @ngayKT is NULL)
		BEGIN
			PRINT 'NGAY KET THUC KHONG HOP LE'
			RETURN
		END
	
	BEGIN TRY
		UPDATE DEAN
			SET DEAN.NGAYKT = @ngayKT
		WHERE DEAN.MADA = @maDA
	END TRY
	BEGIN CATCH
		PRINT 'CAP NHAT KHONG THANH CONG'
		RETURN
	END CATCH

	PRINT 'CAP NHAT THANH CONG'
	RETURN

END

DECLARE @ngayKT datetime = GETDATE()
EXEC usp_UpdateDayEnd 400, @ngayKT
SELECT * FROM DEAN
-----------
--k. Tạo thủ tục phân công nhân viên vào dự án mới. Các tham số vào là: @mada, @manv, @vitri. 
	--Yêu cầu: 
	--o @vitri chỉ nhận một trong 3 giá trị: “Trưởng dự án”, “Trưởng nhóm” và “Thành viên”. Nếu không thỏa điều kiện này thì thông báo và kết thúc thủ tục. 
	--o Nếu @vitri = “Trưởng dự án” thì kiểm tra dự án @duan đã có nhân viên làm “Trưởng dự án” chưa, nếu có rồi thì thông báo và kết thúc thủ tục. 
	--o Nếu các điều kiện trên đều thỏa thì cho thêm mới phân công.
ALTER PROC usp_PhanCong
	@maDA int,
	@maNV char(9),
	@viTri nvarchar(50)
AS
BEGIN
	
	IF @viTri is NULL OR (@viTri <> N'Trưởng dự án' AND @viTri <> N'Trưởng nhóm' AND @viTri <> N'Thành viên')
		BEGIN
			PRINT 'KHONG CO VI TRI NAY'
			RETURN
		END
	IF (SELECT SUM(DEAN.SLTruongDA) FROM DEAN WHERE DEAN.MADA = @maDA) > 0 AND  @viTri = N'Trưởng dự án'
		BEGIN
			PRINT 'DA CO TRUONG DU AN'
			RETURN
		END
	IF EXISTS (SELECT * FROM PHANCONG WHERE PHANCONG.MADA = @maDA AND PHANCONG.MA_NVIEN = @maNV)
		BEGIN
			PRINT 'NHAN VIEN DA THAM GIA DE AN NAY'
			RETURN
		END

	BEGIN TRAN
		--- INSERT  
		BEGIN TRY
			INSERT INTO PHANCONG (MADA, MA_NVIEN, VITRI)
				VALUES (@maDA, @maNV, @viTri)
		END TRY 
		BEGIN CATCH
			PRINT 'LOI KHI THEM DU LIEU'
			ROLLBACK TRAN
			RETURN
		END CATCH
		------UPDATE
		BEGIN TRY
			UPDATE DEAN
			SET 
				DEAN.SLThanhVien = DEAN.SLThanhVien + 1,
				 DEAN.SLTruongDA = CASE 
					WHEN @viTri = N'Trưởng dự án' THEN DEAN.SLTruongDA + 1
						ELSE DEAN.SLTruongDA
					END
				,DEAN.SLTruongNhom = CASE 
					WHEN @viTri = N'Trưởng nhóm' THEN DEAN.SLTruongNhom + 1
						ELSE DEAN.SLTruongNhom
					END
			WHERE DEAN.MADA = @maDA			
		END TRY 
		BEGIN CATCH
			PRINT 'LOI KHI THEM DU LIEU'
			ROLLBACK TRAN
			RETURN
		END CATCH
	COMMIT TRAN

	PRINT 'PHAN CONG THANH CONG'
	RETURN
END

SELECT * FROM DEAN 
DECLARE @viTri nvarchar(50) = N'Trưởng dự án'
EXEC usp_PhanCong 100, '999887777',@viTri
-----------
--LAB 8
--1. TRANSACTION
	--a. Xóa một nhân viên bất kỳ và xóa thông tin trưởng phòng của nhân viên này (không xóa phòng ban, chỉ xóa dữ liệu trưởng phòng và 
	--ngày nhận chức). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.
	--b. Xóa một phòng ban, xóa những địa điểm liên quan
--đến phòng ban, xóa thông tin phòng ban của nhân viên viên thuộc phòng ban này (không xóa nhân viên, chỉ xóa dữ liệu phòng trong nhân viên). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.
--2. FUNCTION
	--Viết hàm xác định một nhân viên có tham gia dự án nào đó với chức vụ là “Trưởng dự án” hay không
--3. TRIGGER
	--Tạo trigger cho ràng buộc: Với mỗi dự án, số lượng “trưởng dự án” phải ít hơn số lượng “trưởng nhóm” và số lượng “trưởng nhóm” phải ít hơn số lượng “thành viên”.
---------

--1. TRANSACTION
	--a. Xóa một nhân viên bất kỳ và xóa thông tin trưởng phòng của nhân viên này (không xóa phòng ban, chỉ xóa dữ liệu trưởng phòng và 
	--ngày nhận chức). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.

CREATE PROC usp_addTEST
AS
BEGIN
	INSERT INTO NHANVIEN(HONV,TENLOT,TEN,MANV,NGSINH,DCHI,PHAI,LUONG,PHG)
						VALUES ('TEST','TEST','TEST','000000000', '2004-01-07', 'DN','NAM', 10, 7)
	--UPDATE NHANVIEN SET PHG = 7 WHERE MANV = '123456789'

	--DELETE FROM NHANVIEN WHERE NHANVIEN.MANV = '123456789' 

	--SELECT * FROM PHONGBAN
	--UPDATE PHONGBAN SET TRPHG = '123456789' WHERE MAPHG = 7
	--SELECT * FROM NHANVIEN
END
-------


CREATE PROC usp_XoaNhanVien
	@maNV char(9)
AS 
BEGIN 
	IF NOT EXISTS(SELECT * FROM NHANVIEN WHERE NHANVIEN.MANV = @maNV) OR @maNV is NULL
		BEGIN
			PRINT 'MA NHAN VIEN KHONG TON TAI'
			RETURN
		END

	BEGIN TRAN
			IF EXISTS(SELECT * FROM PHONGBAN WHERE PHONGBAN.TRPHG = @maNV)
				BEGIN
					BEGIN TRY
						UPDATE PHONGBAN 
							SET TRPHG = NULL 
						WHERE PHONGBAN.MAPHG = (SELECT NHANVIEN.PHG FROM NHANVIEN WHERE NHANVIEN.MANV = @maNV)
					END TRY
					BEGIN CATCH
						PRINT 'XOA TRUONG PHONG KHONG THANH CONG'
						ROLLBACK TRAN
					END CATCH
				END
			
			IF EXISTS(SELECT * FROM THANNHAN WHERE THANNHAN.MA_NVIEN = @maNV)
				BEGIN
					BEGIN TRY
						DELETE FROM THANNHAN WHERE THANNHAN.MA_NVIEN = @maNV
					END TRY
					BEGIN CATCH
						PRINT 'LOI KHI XOA THAN NHAN NV'
						ROLLBACK TRAN
						RETURN
					END CATCH
				END

			IF EXISTS(SELECT * FROM PHANCONG WHERE PHANCONG.MA_NVIEN = @maNV)
				BEGIN 
					BEGIN TRY
						DELETE FROM PHANCONG WHERE PHANCONG.MA_NVIEN = @maNV
					END TRY
					BEGIN CATCH
						PRINT 'LOI KHI XOA PHAN CONG NV'
						ROLLBACK TRAN
						RETURN
					END CATCH
				END

			BEGIN TRY
				DELETE FROM NHANVIEN WHERE NHANVIEN.MANV = @maNV
			END TRY
			BEGIN CATCH
				PRINT 'LOI KHI XOA NV'
				ROLLBACK TRAN
				RETURN
			END CATCH

	COMMIT TRAN
	PRINT 'XOA NHAN VIEN THANH CONG'
	RETURN
END

EXEC usp_XoaNhanVien '123456789'

	--b. Xóa một phòng ban, xóa những địa điểm liên quan
CREATE PROC usp_addDiaDiem
AS
BEGIN
	INSERT INTO DIADIEM_PHG(MAPHG, DIADIEM)
		VALUES(7,'Quang TRi'),
				(7,'Quang TRi1'),
				(7,'Quang TRi2')
END
------

ALTER PROC usp_XoaPhongBan
	@maPB int
AS
BEGIN 
	IF NOT EXISTS(SELECT * FROM PHONGBAN WHERE MAPHG = @maPB) OR @maPB is NULL
		BEGIN
			PRINT 'KHONG TON TAI PHONG BAN NAY'
			RETURN
		END

	BEGIN TRAN
		IF EXISTS(SELECT * FROM DIADIEM_PHG WHERE MAPHG = @maPB)
			BEGIN
				BEGIN TRY
					DELETE FROM DIADIEM_PHG WHERE DIADIEM_PHG.MAPHG = @maPB
				END TRY
				BEGIN CATCH
					PRINT 'XOA DIA DIEM PHONG KHONG THANH CONG'
					ROLLBACK TRAN
					RETURN
				END CATCH
			END

		IF EXISTS(SELECT * FROM NHANVIEN WHERE NHANVIEN.PHG = @maPB)
			BEGIN
				BEGIN TRY
					UPDATE NHANVIEN SET PHG = NULL WHERE NHANVIEN.PHG = @maPB
				END TRY
				BEGIN CATCH
					PRINT 'CAP NHAT NHAN VIEN LOI'
					ROLLBACK TRAN
					RETURN
				END CATCH
			END

		BEGIN TRY
			DELETE FROM PHONGBAN WHERE PHONGBAN.MAPHG = @maPB
		END TRY
		BEGIN CATCH
			PRINT 'XOA PHONG BAN KHONG THANH CONG'
			ROLLBACK TRAN
			RETURN
		END CATCH

		PRINT 'XOA PHONG BAN THANH CONG'
		COMMIT TRAN
		RETURN
END

EXEC usp_addDiaDiem

SELECT * FROM PHONGBAN

EXEC usp_XoaPhongBan 7

------------
--2. FUNCTION
	--Viết hàm xác định một nhân viên có tham gia dự án nào đó với chức vụ là “Trưởng dự án” hay không
CREATE FUNCTION usf_ChucVu(@maNV char(9), @maDA int)
	RETURNS nvarchar(50)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE NHANVIEN.MANV = @maNV)
		BEGIN 
			RETURN 'KHONG TON TAI NHAN VIEN'
		END
	IF NOT EXISTS (SELECT * FROM PHANCONG WHERE PHANCONG.MADA = @maDA)
		BEGIN 
			RETURN 'KHONG TON DU AN NAY'
		END

	IF EXISTS (SELECT * FROM PHANCONG WHERE PHANCONG.MA_NVIEN = @maNV AND PHANCONG.MADA = @maDA)
		BEGIN 
			IF EXISTS(SELECT * FROM PHANCONG WHERE PHANCONG.MA_NVIEN = @maNV AND VITRI = N'Trưởng dự án' AND PHANCONG.MADA = @maDA)
				RETURN 'LA TRUONG DU AN'
			ELSE 
				RETURN 'KHONG PHAI TRUONG DU AN'
		END
	RETURN 'KHONG THAM GIA DU AN'
END

SELECT * FROM NHANVIEN
SELECT * FROM PHANCONG
PRINT dbo.usf_ChucVu('987987987',200)

-------------
--3. TRIGGER
	--Tạo trigger cho ràng buộc: Với mỗi dự án, số lượng “trưởng dự án” phải ít hơn số lượng “trưởng nhóm” và số lượng “trưởng nhóm” phải ít hơn số lượng “thành viên”.
ALTER TRIGGER ust_DuAn
ON PHANCONG
AFTER INSERT, UPDATE 
AS
BEGIN
	DECLARE cur_DeAn CURSOR
		FORWARD_ONLY
	FOR 
		SELECT DISTINCT i.MADA
        FROM INSERTED i
        UNION
        SELECT DISTINCT d.MADA
        FROM DELETED d

	OPEN cur_DeAn

	DECLARE @maDA int

	fetch next FROM cur_DeAn into @maDA
	WHILE(@@FETCH_STATUS = 0)
		BEGIN 
			DECLARE @soTruongDA int = 0, @soTruongNhom int = 0 , @soThanhVien int = 0

			SET @soTruongNhom = (SELECT COUNT(*) FROM PHANCONG WHERE MADA = @maDA AND VITRI = N'Trưởng Nhóm')

			SET @soTruongDA = (SELECT COUNT(*) FROM PHANCONG WHERE MADA = @maDA AND VITRI = N'Trưởng Dự Án')

			SET @soThanhVien = (SELECT COUNT(PHANCONG.MA_NVIEN) FROM PHANCONG WHERE  MADA = @maDA)

			IF(@soTruongDA >= @soThanhVien OR @soTruongDA >= @soTruongNhom)
				BEGIN
					PRINT 'LOI KHI THEM SO TRUONG DU AN'
					ROLLBACK
					CLOSE cur_DeAn
					DEALLOCATE cur_DeAn
					RETURN
				END
			IF(@soTruongNhom >= @soThanhVien)
				BEGIN
					PRINT 'LOI KHI THEM TRUONG NHOM'
					ROLLBACK
					CLOSE cur_DeAn
					DEALLOCATE cur_DeAn
					RETURN
				END

			UPDATE DEAN
				 SET SLTruongDA = @soTruongDA,
					SLTruongNhom = @soTruongNhom,
					SLThanhVien = @soThanhVien
			WHERE MADA = @maDA

			fetch next FROM cur_DeAn into @maDA
		END
	
	CLOSE cur_DeAn
	DEALLOCATE cur_DeAn
	
END

INSERT INTO PHONGBAN(MAPHG,TENPHONG)
	VALUES  (7,'TESTSSSS')

INSERT INTO NHANVIEN(HONV,TENLOT,TEN,MANV,NGSINH,DCHI,PHAI,LUONG,PHG)
Values	(N'TEST1',N'TEST1',N'TEST1','000000000','1970-01-09',N'TPHCM',N'Nam',30000,7),
		(N'TEST2',N'TEST2',N'TEST2','000000001','1970-01-09',N'TPHCM',N'Nam',30000,7),
		(N'TEST3',N'TEST3',N'TEST3','000000002','1970-01-09',N'TPHCM',N'Nam',30000,7)

INSERT INTO PHANCONG(MADA,MA_NVIEN,VITRI)
values	(300,'000000001',N'Nhân Viên')