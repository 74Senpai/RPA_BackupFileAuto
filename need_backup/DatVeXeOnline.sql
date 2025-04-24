USE master

IF EXISTS ( SELECT 1 From sys.databases WHERE name = 'Dat_Ve_Xe_Online' ) 
	BEGIN 
		DROP DATABASE Dat_Ve_Xe_Online
	END
GO

CREATE DATABASE Dat_Ve_Xe_Online
ON  
	(Name = DVXe_Data, Filename='Z:\Sql\DVXe_Data.mdf',  Size = 3MB, Filegrowth = 5% )
LOG ON 
	(Name = DVXe_Log, Filename='Z:\Sql\DVXe_Data.ldf',  Size = 3MB, Filegrowth = 5% )
GO

USE Dat_Ve_Xe_Online

CREATE TABLE KhachHang (
	maKhachHang char(5) NOT NULL,
	tenKhachHang nvarchar(50) NOT NULL,
	soDienThoai char(10) NOT NULL,
	email varchar(255)
)
GO

CREATE TABLE HoaDon (
	maHoaDon char(5) NOT NULL,
	maKhachHang char(5) NOT NULL,
	tongGia money ,
	trinhTrang nvarchar(25) NOT NULL,
	ngayTao datetime NOT NULL
)
GO

CREATE TABLE TuyenXe (
	maTuyenXe char(5) NOT NULL,
	diemDau nvarchar(100) NOT NULL,
	diemCuoi nvarchar (100) NOT NULL,
	tinhTrang nvarchar (100) NOT NULL,
	moTa nvarchar (255) NOT NULL
)
GO 

CREATE TABLE Xe (
	maXe char(5) NOT NULL,
	tenXe nvarchar(50) NOT NULL,
	loaiXe nvarchar(50) NOT NULL,
	bienSoXe varchar(10) NOT NULL,
	tinhTrang nvarchar (100) NOT NULL,
	soDienThoai char(10) NOT NULL
)
GO

CREATE TABLE Ghe (
	maGhe char(2) NOT NULL,
	maXe char(5) NOT NULL,
	tinhTrang nvarchar(20) NOT NULL
)
GO 

CREATE TABLE ChuyenXe (
	maChuyenXe char(5) NOT NULL,
	maTuyenXe char(5) NOT NULL,
	maXe char(5) NOT NULL,
	thoiGianXuatPhat datetime NOT NULL,
	thoiGianKetThuc datetime NOT NULL,
	tinhTrang nvarchar(50) NOT NULL
)
GO 

CREATE TABLE Ve (
	maVe char(5) NOT NULL,
	maHoaDon char(5) NULL,
	maKhachHang char(5) NULL,
	maChuyenXe char(5) NOT NULL,
	maGhe char(2) NOT NULL,
	tinhTrang nvarchar(25) NOT NULL,
	giaVe money
)
GO

ALTER TABLE KhachHang 
	ADD 
		CONSTRAINT pk_KhachHang PRIMARY KEY (maKhachHang)
GO

ALTER TABLE TuyenXe
	ADD
		CONSTRAINT pk_TuyenXe PRIMARY KEY (maTuyenXe)
GO

ALTER TABLE Xe 
	ADD 
		CONSTRAINT pk_Xe PRIMARY KEY (maXe)
GO

ALTER TABLE Ghe
	ADD 
		CONSTRAINT pk_Ghe PRIMARY KEY (maGhe, maXe),
		CONSTRAINT fk_Ghe_Xe FOREIGN KEY (maXe) REFERENCES Xe(maXe)
GO

ALTER TABLE ChuyenXe 
	ADD 
		CONSTRAINT pk_ChuyenXe PRIMARY KEY (maChuyenXe),
		CONSTRAINT fk_ChuyenXe_TuyenXe FOREIGN KEY (maTuyenXe) REFERENCES TuyenXe(maTuyenXe),
		CONSTRAINT fk_ChuyenXe_Xe FOREIGN KEY (maXe) REFERENCES Xe(maXe)
GO

ALTER TABLE HoaDon
	ADD
		CONSTRAINT pk_HoaDon PRIMARY KEY (maHoaDon),
		CONSTRAINT fk_HoaDon_KhachHang FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang)
GO

ALTER TABLE Ve
	ADD 
		CONSTRAINT pk_Ve PRIMARY KEY (maVe),
		CONSTRAINT fk_Ve_Chuyen_Xe FOREIGN KEY (maChuyenXe) REFERENCES ChuyenXe(maChuyenXe),
		CONSTRAINT fk_Ve_KhachHang FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang),
		CONSTRAINT fk_Ve_HoaDon FOREIGN KEY (maHoaDon) REFERENCES HoaDon(maHoaDon)
GO


INSERT INTO KhachHang VALUES
	('KH001', N'Nguyễn Văn A', '0909123456', 'a1@example.com'),
	('KH002', N'Trần Thị B', '0909123457', 'b2@example.com'),
	('KH003', N'Lê Văn C', '0909123458', 'c3@example.com'),
	('KH004', N'Phạm Thị D', '0909123459', 'd4@example.com'),
	('KH005', N'Vũ Văn E', '0909123460', 'e5@example.com'),
	('KH006', N'Đỗ Thị F', '0909123461', 'f6@example.com'),
	('KH007', N'Hồ Văn G', '0909123462', 'g7@example.com'),
	('KH008', N'Bùi Thị H', '0909123463', 'h8@example.com'),
	('KH009', N'Ngô Văn I', '0909123464', 'i9@example.com'),
	('KH010', N'Dương Thị J', '0909123465', 'j10@example.com'),
	('KH011', N'Nguyễn Văn K', '0909123466', 'k11@example.com'),
	('KH012', N'Trần Thị L', '0909123467', 'l12@example.com'),
	('KH013', N'Lê Văn M', '0909123468', 'm13@example.com'),
	('KH014', N'Phạm Thị N', '0909123469', 'n14@example.com'),
	('KH015', N'Vũ Văn O', '0909123470', 'o15@example.com'),
	('KH016', N'Đỗ Thị P', '0909123471', 'p16@example.com'),
	('KH017', N'Hồ Văn Q', '0909123472', 'q17@example.com'),
	('KH018', N'Bùi Thị R', '0909123473', 'r18@example.com'),
	('KH019', N'Ngô Văn S', '0909123474', 's19@example.com'),
	('KH020', N'Dương Thị T', '0909123475', 't20@example.com');
GO

INSERT INTO TuyenXe VALUES
	('TX001', N'Hà Nội', N'Hải Phòng', N'Hoạt động', N'Tuyến đi từ Hà Nội đến Hải Phòng'),
	('TX002', N'Hồ Chí Minh', N'Vũng Tàu', N'Hoạt động', N'Tuyến đi từ HCM đến Vũng Tàu'),
	('TX003', N'Đà Nẵng', N'Huế', N'Hoạt động', N'Tuyến đi miền Trung'),
	('TX004', N'Cần Thơ', N'Châu Đốc', N'Tạm dừng', N'Tuyến đi miền Tây'),
	('TX005', N'Hà Nội', N'Ninh Bình', N'Hoạt động', N'Tuyến ngắn ngày');
Go

INSERT INTO Xe VALUES
	('XE001', N'Xe 45 chỗ', N'Ghế ngồi', '51A-12345', N'Hoạt động', '0911122233'),
	('XE002', N'Xe VIP', N'Giường nằm', '29B-67890', N'Bảo trì', '0911122234'),
	('XE003', N'Xe Thường', N'Ghế ngồi', '63C-45678', N'Hoạt động', '0911122235'),
	('XE004', N'Xe Limousine', N'Limousine', '77D-56789', N'Hoạt động', '0911122236'),
	('XE005', N'Xe mini', N'16 chỗ', '30E-12333', N'Hoạt động', '0911122237');
GO

INSERT INTO ChuyenXe VALUES
	('CX001', 'TX001', 'XE001', '2025-04-15 07:00:00', '2025-04-15 10:00:00', N'Đã hoàn thành'),
	('CX002', 'TX002', 'XE002', '2025-04-16 08:00:00', '2025-04-16 11:30:00', N'Chưa khởi hành'),
	('CX003', 'TX003', 'XE003', '2025-04-17 13:00:00', '2025-04-17 15:00:00', N'Đã hoàn thành'),
	('CX004', 'TX004', 'XE004', '2025-04-18 10:00:00', '2025-04-18 12:30:00', N'Hoãn'),
	('CX005', 'TX005', 'XE005', '2025-04-19 06:30:00', '2025-04-19 08:00:00', N'Đã hoàn thành'),
	('CX006', 'TX001', 'XE001', '2025-04-20 07:00:00', '2025-04-20 10:00:00', N'Đã hoàn thành'),
	('CX007', 'TX002', 'XE002', '2025-04-21 08:00:00', '2025-04-21 11:30:00', N'Chưa khởi hành'),
	('CX008', 'TX003', 'XE003', '2025-04-22 13:00:00', '2025-04-22 15:00:00', N'Đã hoàn thành'),
	('CX009', 'TX004', 'XE004', '2025-04-23 10:00:00', '2025-04-23 12:30:00', N'Hoãn'),
	('CX010', 'TX005', 'XE005', '2025-04-24 06:30:00', '2025-04-24 08:00:00', N'Đã hoàn thành');
GO

INSERT INTO HoaDon VALUES
	('HD001', 'KH001', 100000, N'Đã thanh toán', '2025-04-10'),
	('HD002', 'KH002', 120000, N'Chờ thanh toán', '2025-04-11'),
	('HD003', 'KH003', 150000, N'Đã thanh toán', '2025-04-12'),
	('HD004', 'KH004', 180000, N'Đã thanh toán', '2025-04-13'),
	('HD005', 'KH005', 200000, N'Chờ thanh toán', '2025-04-14'),
	('HD006', 'KH006', 170000, N'Đã thanh toán', '2025-04-15'),
	('HD007', 'KH007', 160000, N'Đã thanh toán', '2025-04-16'),
	('HD008', 'KH008', 190000, N'Chờ thanh toán', '2025-04-17'),
	('HD009', 'KH009', 175000, N'Đã thanh toán', '2025-04-18'),
	('HD010', 'KH010', 140000, N'Đã thanh toán', '2025-04-19'),
	('HD011', 'KH011', 130000, N'Đã thanh toán', '2025-04-20'),
	('HD012', 'KH012', 125000, N'Đã thanh toán', '2025-04-21'),
	('HD013', 'KH013', 145000, N'Đã thanh toán', '2025-04-22'),
	('HD014', 'KH014', 165000, N'Chờ thanh toán', '2025-04-23'),
	('HD015', 'KH015', 185000, N'Đã thanh toán', '2025-04-24'),
	('HD016', 'KH016', 195000, N'Đã thanh toán', '2025-04-25'),
	('HD017', 'KH017', 205000, N'Chờ thanh toán', '2025-04-26'),
	('HD018', 'KH018', 215000, N'Đã thanh toán', '2025-04-27'),
	('HD019', 'KH019', 225000, N'Đã thanh toán', '2025-04-28'),
	('HD020', 'KH020', 235000, N'Chờ thanh toán', '2025-04-29');
GO


-- Ghế cho XE001
INSERT INTO Ghe VALUES
	('A1', 'XE001', N'Trống'),
	('A2', 'XE001', N'Đã đặt'),
	('A3', 'XE001', N'Trống'),
	('A4', 'XE001', N'Đã đặt'),

	-- Ghế cho XE002
	('B1', 'XE002', N'Trống'),
	('B2', 'XE002', N'Trống'),
	('B3', 'XE002', N'Đã đặt'),
	('B4', 'XE002', N'Trống'),

	-- Ghế cho XE003
	('C1', 'XE003', N'Trống'),
	('C2', 'XE003', N'Đã đặt'),
	('C3', 'XE003', N'Trống'),
	('C4', 'XE003', N'Đã đặt'),

	-- Ghế cho XE004
	('D1', 'XE004', N'Trống'),
	('D2', 'XE004', N'Trống'),
	('D3', 'XE004', N'Trống'),
	('D4', 'XE004', N'Đã đặt'),

	-- Ghế cho XE005
	('E1', 'XE005', N'Trống'),
	('E2', 'XE005', N'Đã đặt'),
	('E3', 'XE005', N'Trống'),
	('E4', 'XE005', N'Trống');
GO


-- Ghế mới cho các vé trống
INSERT INTO Ghe VALUES
	('K1', 'XE001', N'Trống'),
	('K2', 'XE002', N'Trống'),
	('K3', 'XE003', N'Trống'),
	('K4', 'XE004', N'Trống'),
	('K5', 'XE005', N'Trống'),
	('K6', 'XE001', N'Trống'),
	('K7', 'XE002', N'Trống'),
	('K8', 'XE003', N'Trống'),
	('K9', 'XE004', N'Trống'),
	('K10','XE005', N'Trống');

GO


INSERT INTO Ve VALUES
	('VE001', 'HD001', 'KH001', 'CX001', 'A1', N'Đã thanh toán', 100000),
	('VE002', 'HD002', 'KH002', 'CX002', 'A2', N'Chờ thanh toán', 120000),
	('VE003', 'HD003', 'KH003', 'CX003', 'B1', N'Đã thanh toán', 150000),
	('VE004', 'HD004', 'KH004', 'CX004', 'B2', N'Đã thanh toán', 180000),
	('VE005', 'HD005', 'KH005', 'CX005', 'C1', N'Chờ thanh toán', 200000),
	('VE006', 'HD006', 'KH006', 'CX006', 'C2', N'Đã thanh toán', 170000),
	('VE007', 'HD007', 'KH007', 'CX007', 'D1', N'Đã thanh toán', 160000),
	('VE008', 'HD008', 'KH008', 'CX008', 'D2', N'Chờ thanh toán', 190000),
	('VE009', 'HD009', 'KH009', 'CX009', 'E1', N'Đã thanh toán', 175000),
	('VE010', 'HD010', 'KH010', 'CX010', 'E2', N'Đã thanh toán', 140000),
	('VE011', 'HD011', 'KH011', 'CX001', 'F1', N'Đã thanh toán', 130000),
	('VE012', 'HD012', 'KH012', 'CX002', 'F2', N'Đã thanh toán', 125000),
	('VE013', 'HD013', 'KH013', 'CX003', 'G1', N'Đã thanh toán', 145000),
	('VE014', 'HD014', 'KH014', 'CX004', 'G2', N'Chờ thanh toán', 165000),
	('VE015', 'HD015', 'KH015', 'CX005', 'H1', N'Đã thanh toán', 185000),
	('VE016', 'HD016', 'KH016', 'CX006', 'H2', N'Đã thanh toán', 195000),
	('VE017', 'HD017', 'KH017', 'CX007', 'I1', N'Chờ thanh toán', 205000),
	('VE018', 'HD018', 'KH018', 'CX008', 'I2', N'Đã thanh toán', 215000),
	('VE019', 'HD019', 'KH019', 'CX009', 'J1', N'Đã thanh toán', 225000),
	('VE020', 'HD020', 'KH020', 'CX010', 'J2', N'Chờ thanh toán', 235000);
GO

INSERT INTO Ve VALUES
	('VE021', NULL, NULL, 'CX001', 'K1', N'Chưa đặt', 100000),
	('VE022', NULL, NULL, 'CX002', 'K2', N'Chưa đặt', 120000),
	('VE023', NULL, NULL, 'CX003', 'K3', N'Chưa đặt', 150000),
	('VE024', NULL, NULL, 'CX004', 'K4', N'Chưa đặt', 180000),
	('VE025', NULL, NULL, 'CX005', 'K5', N'Chưa đặt', 200000),
	('VE026', NULL, NULL, 'CX006', 'K6', N'Chưa đặt', 170000),
	('VE027', NULL, NULL, 'CX007', 'K7', N'Chưa đặt', 160000),
	('VE028', NULL, NULL, 'CX008', 'K8', N'Chưa đặt', 190000),
	('VE029', NULL, NULL, 'CX009', 'K9', N'Chưa đặt', 175000),
	('VE030', NULL, NULL, 'CX010', 'K10', N'Chưa đặt', 140000);
GO

