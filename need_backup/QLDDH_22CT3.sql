USE master -- sử dụng CSDL
Go
-- TẠO CSDL
-- Xóa CSDL, tr19
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'QLDDH_22CT3')
	BEGIN
		drop database QLDDH_22CT3
	END
Go
-- TẠO CSDL, TR18
create database QLDDH_22CT3
	ON
		( Name=QLDDH_22CT3, Filename='E:\Sql\QLDDH_22CT3.mdf', 
		Size=10MB, Maxsize=10MB, Filegrowth = 1MB )
	LOG On 
		( Name=QLDDH_22CT3_LOG, Filename='E:\Sql\QLDDH_22CT3.ldf') 
Go
USE QLDDH_22CT3
Go
--- TẠO BẢNG, tr19
create table KhachHang(
	MaKH char(5) not null, --primary key,  --kiểu dữ liệu, tr20
	TenKH nvarchar(50),
	DiaChi nvarchar(20),
	DienThoai varchar(15),
	--constraint pk_KhachHang primary key(MaKH)
)
go
CREATE TABLE HangHoa --tạo bảng HangHoa
(
   MaHH char(5) not null,
   TenHH nvarchar(50) not null,
   DVT nvarchar(20),
   SLCon int not null,
   DonGiaHH int
)
go
CREATE TABLE DonDatHang
(
  MaDat  char(5) not null,
  NgayDat date,
  MaKH char(5)
  --constraint pk_DonDatHang primary key(MaDat),
 -- CONSTRAINT fk_DonDatHang_MaKH FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)
)

CREATE TABLE ChiTietDatHang
(
  MaDat    char(5) not null,
  MaHH     char(5) not null,
  SLDat    int
)

CREATE TABLE PhieuGiaoHang
(
   MaGiao   char(5) not null,
   NgayGiao  date,
   MaDat      char(5)
)

CREATE TABLE ChiTietGiaoHang
(
   MaGiao      char(5) not null,
   MaHH      char(5) not null,
   SLGiao      int,
   DonGiaGiao   int
)

CREATE TABLE LichSuGia
(
   MaHH      char(5) not null,
   NgayHL    date not null,
   DonGia    int
)
---------------SỬA BẢNG, alter table, tr25
--thêm các ràng buộc khóa chính, khóa ngoại
alter table KhachHang
	add
	 constraint pk_KhachHang primary key(MaKH)
go
ALTER TABLE HangHoa
	add
		constraint pk_HangHoa primary key(MaHH)
go
alter table LichSuGia
	add 
		constraint pk_LichSuGia primary key(MaHH,NgayHL),
		constraint fk_LichSuGia foreign key (MaHH) references HangHoa(MaHH)-- on delete cascade
Go
alter table DonDatHang
	add 
	constraint pk_DonDatHang primary key(MaDat),
	constraint fk_DonDatHang_MaKH foreign key(MaKH)	references KhachHang(MaKH)
go
alter table ChiTietDatHang
	add constraint pk_ChiTietDatHang primary key(MaDat,MaHH),
		constraint fk_ChiTietDatHang_MaDat foreign key (MaDat) references DonDatHang(MaDat),
		constraint fk_ChiTietDatHang_MaHH foreign key (MaHH) references HangHoa(MaHH) on delete cascade
go
alter table PhieuGiaoHang
	add 
		constraint pk_PhieuGiaoHang primary key(MaGiao),
		constraint fk_PhieuGiaoHang_MaDat foreign key(MaDat) references DonDatHang(MaDat)
go
alter table ChiTietGiaoHang
	add 
		constraint pk_ChiTietGiaoHang primary key(MaGiao,MaHH),
		constraint fk_ChiTietGiaoHang_MaGiao foreign key (MaGiao) references PhieuGiaoHang(MaGiao),
		constraint fk_ChiTietGiaoHang_MaHH foreign key (MaHH) references HangHoa(MaHH) on delete cascade
go
--b. Thêm ràng buộc duy nhất (UNIQUE) cho trường TenHH trong bảng HangHoa, thử
--nhập dữ liệu để kiểm tra ràng buộc.
alter table HangHoa -- tr22
	add
		constraint  un_HangHoa_TenHH unique (TenHH)
--c. Thêm ràng buộc kiểm tra (CHECK) cho trường SLCon, yêu cầu là trường này chỉ
--nhận giá trị >=0, thử nhập dữ liệu để kiểm tra ràng buộc.
alter table HangHoa
	add
		constraint chk_HangHoa_SLCon check (SLCon>=0)
--d. Thêm ràng buộc mặc định (DEFAULT) cho cột NgayDat trong DonDatHang với giá 
--trị mặc định là ngày hiện tại, thử nhập dữ liệu để kiểm tra ràng buộc.
alter table DonDatHang
	add
		constraint df_DonDatHang_NgayDat default (GETDATE()) for NgayDat
--e. Xóa bảng KHACHHANG? Nếu không xóa được thì nêu lý do? Muốn xóa được thì 
--phải làm sao?
	----1. Xóa khóa ngoai
	--alter table DonDatHang
	--	drop
	--		fk_DonDatHang_MaKH
	----2. Xóa bảng
	--drop table KhachHang  --tr25
--f. Xóa cột DiaChi trong bảng KhachHang, sau đó tạo lại cột này với ràng buộc mặc định 
--là “Đà Nẵng”.
	
--g. Xóa khóa ngoại MaDat trong PHIEUGIAOHANG tham chiếu tới MaDat trong 
--DonDatHang, sau đó tạo lại khóa ngoại này.
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--NHẬP DỮ LIỆU, INSERT, tr26
SET DATEFORMAT mdy -- định dạng nhập liệu tháng-ngày-năm
go
-- Bảng Hàng Hóa
insert into HangHoa(MaHH,TenHH,DVT,SLCon,DonGiaHH)
values('BU',N'Bàn ủi Philip',N'Cái',60,350000)
insert into HangHoa(MaHH,TenHH,DVT,SLCon,DonGiaHH)
values('CD',N'Nồi cơm điện Sharp',N'Cái',100,700000)
insert into HangHoa(MaHH,TenHH,DVT,SLCon,DonGiaHH)
values('DM',N'Đầu Máy Sharp',N'Cái',75,1200000)
insert into HangHoa(MaHH,TenHH,DVT,SLCon,DonGiaHH)
values('MG',N'Máy Giặt SanYo',N'Cái',10,4700000)
insert into HangHoa(MaHH,TenHH,DVT,SLCon,DonGiaHH)
values('MQ',N'Máy Quạt ASIA',N'Cái',40,400000)
insert into HangHoa(MaHH,TenHH,DVT,SLCon,DonGiaHH)
values('TL',N'Tủ lạnh Hitachi',N'Cái',50,5500000)
insert into HangHoa(MaHH,TenHH,DVT,SLCon,DonGiaHH)
values('TV',N'TiVi JVC 14WS',N'Cái',33,7800000)
go
--Nhập liệu bảng KhachHang
insert into KhachHang(MaKH,TenKH,DiaChi,DienThoai)
values
	('KH001',N'Cửa hàng Phú Lộc',N'Đà Nẵng','0511.4613'),
	('KH002',N'Cửa hàng Hoàng Gia',N'Quảng Nam','0510.3344'),
	('KH003',N'Nguyễn Lan Anh',N'Huế','0988.1488'),
	('KH004',N'Công ty TNHH An Phước',N'Đà Nẵng','0511.6978'),
	('KH005',N'Huỳnh Ngọc Trung',N'Quảng Nam','0905.8885'),
	('KH006',N'Cửa Hàng Trung Tín',N'Đà Nẵng',null)
go
--Nhập liệu bảng LichSuGia
insert into LichSuGia(MaHH,NgayHL,DonGia)
values
	('BU','01-01-2011',300000),
	('BU','01-01-2012',350000),
	('CD','01-06-2011',650000),
	('CD','01-01-2012',700000),
	('DM','01-01-2011',1000000),
	('DM','01-01-2012',1200000),
	('MG','01-01-2011',4700000),
	('MQ','06-01-2011',400000),
	('TL','01-01-2011',5000000),
	('TL','01-01-2012',5500000),
	('TV','01-01-2012',7800000)
go
-- Bảng DonDatHang
insert into DonDatHang(MaDat,NgayDat,MaKH)
values('DH01','02-02-2011','KH001'),
		('DH02','12-02-2011','KH003'),
		('DH03','01-22-2011','KH003'),
		('DH04','03-22-2011','KH002'),
		('DH05','04-14-2012','KH005'),
		('DH06','05-08-2012','KH003'),
		('DH07','11-25-2012','KH005')
go
insert into PhieuGiaoHang(MaGiao,NgayGiao,MaDat)
values('GH01','02-02-2011','DH01')
insert into PhieuGiaoHang(MaGiao,NgayGiao,MaDat)
values('GH02','02-15-2012','DH02')
insert into PhieuGiaoHang(MaGiao,NgayGiao,MaDat)
values('GH03','01-23-2011','DH03')
insert into PhieuGiaoHang(MaGiao,NgayGiao,MaDat)
values('GH05','04-20-2012','DH05')
insert into PhieuGiaoHang(MaGiao,NgayGiao,MaDat)
values('GH06','08-05-2012','DH06')

go
insert into ChiTietDatHang(MaDat,MaHH,SLDat)
values('DH01','BU',15),
		('DH01','DM',10),
		('DH01','TL',4),
		('DH02','BU',20),
		('DH02','TL',3),
		('DH03','MG',8),
		('DH04','TL',5),
		('DH05','BU',12),
		('DH05','DM',15),
		('DH05','MG',6),
		('DH05','TL',5),
		('DH06','BU',30),
		('DH06','MG',7)
go
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH01','BU',15,300000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH01','DM',10,1000000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH01','TL',4,5000000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH02','BU',10,300000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH03','MG',8,4700000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH05','BU',12,350000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH05','DM',15,1200000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH05','MG',5,4700000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH05','TL',5,5500000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH06','BU',20,350000)
insert into ChiTietGiaoHang(MaGiao,MaHH,SLGiao,DonGiaGiao)
values('GH06','MG',7,4700000)
go
--TRUY VẤN, QUERY, SELECT, TR29
select  MaKH as [Mã khách hàng]
from KhachHang
where MaKH='KH002'
-- Lấy tất cả thông tin khách hàng
select *
from KhachHang
-- Lấy MaKH,TenKH .đổi tên MaKH thành 'Mã khách hàng', đổi tên cột, tr30
select  MaKH as [Mã khách hàng], TenKH as 'Tên Khách hàng'
from KhachHang
-- Lấy ra khách hàng ở Đà Nẵng, so sánh tr33
select *
from KhachHang
where DiaChi = N'Đà Nẵng'
-- khách hàng ở Quảng Nam hoặc Đà Nẵng, gộp điều kiện AND OR NOT
select *
from KhachHang
where DiaChi = N'Đà Nẵng' OR DiaChi = N'Quảng Nam'
-- khách hàng không có số điện thoại, NULL, tr35
select *
from KhachHang
where DienThoai is NULL
-- khách hàng ở Quảng Nam, hoặc Quảng Ngãi hoặc Quảng Bình
select *
from KhachHang
where DiaChi in (N'Quảng Ngãi',N'Quảng Nam',N'Quảng Bình') -- in   not in, tr35
-- Khách hàng có tên bắt đầu là 'Cửa hàng', like, tr34
select *
from KhachHang
where TenKH like N'Cửa hàng%'
-- Khách hàng trong SDT có dấu '.'
select *
from KhachHang
where DienThoai like '%.%'
-- Hàng hóa có 10<= SLCon <=100
select *
from HangHoa
where --SLCon >=10 and SLCon <=100
		SLCon between 40 and 100 
-- Hàng hóa của hãng Sharp
select *
from HangHoa
where TenHH like '%Sharp%'
-- Hàng hóa của hãng Sharp mà SLCon >=100
select *
from HangHoa
where TenHH like '%Sharp%' and SLCon >=100
-- Sắp xếp dữ liệu bảng HangHoa giảm dần theo DonGiaHH, order by, sắp xếp dữ liệu, tr36
select top 1 *  
from HangHoa
order by DonGiaHH desc
-- distinct, tr32, loại kết quả trùng lặp
select distinct MaKH
from DonDatHang
-- case..when, tr31.
select *, GhiChu = Case
						when SLCon >=60 then N'Bán ế'
						when SLCon <=10 then N'Bán chạy'
						else ''
					end
from HangHoa

select * from DonDatHang
select * from ChiTietDatHang
select * from HangHoa
select * from PhieuGiaoHang
select * from LichSuGia
--++++++++++++++++++++++++++++++
--NỐI BẢNG
--------------------------------------
-- Lấy MaKH, TenKH đã đặt hàng
--cách 1: tích đề các, tr37
select distinct ddh.MaKH, kh.TenKH
from KhachHang as kh, DonDatHang as ddh
where kh.MaKH = ddh.MaKH
--cách 2: inner join, nối nội, tr39
select distinct ddh.MaKH, kh.TenKH
from KhachHang as kh
	inner join DonDatHang as ddh on kh.MaKH = ddh.MaKH
--a. Cho biết chi tiết giao hàng của đơn đặt hàng DH01, hiển thị: tên hàng hóa, số lượng 
--giao và đơn giá giao.
select hh.TenHH,ctgh.SLGiao,ctgh.DonGiaGiao
from ChiTietGiaoHang as ctgh
	inner join HangHoa as hh on hh.MaHH=ctgh.MaHH
	inner join PhieuGiaoHang as pgh on pgh.MaGiao=ctgh.MaGiao
where pgh.MaDat='DH01'
-- lấy thông tin những đơn đặt hàng đã được giao trong năm 2012
select ddh.*
from DonDatHang as ddh
	inner join PhieuGiaoHang as pgh on ddh.MaDat=pgh.MaDat
where year(NgayGiao) =2012
-- b. Cho biết thông tin những đơn đặt hàng không được giao, hiển thị: mã đặt, ngày đặt, 
--tên khách hàng.
	--c1: toán tử in  , tr34
select DonDatHang.MaDat, DonDatHang.NgayDat,KhachHang.TenKH 
from DonDatHang
	inner join KhachHang on KhachHang.MaKH=DonDatHang.MaKH
where MaDat not in (select MaDat     --truy vấn lồng nhau, sub query
					from PhieuGiaoHang)
	--c2: toán tử exist
select *
from DonDatHang as ddh
where not exists (select *
				from PhieuGiaoHang as pgh
				where ddh.MaDat=pgh.MaDat)
	--c3: toán tử tập hợp, hội- giao- trừ, tr41
select t1.MaDat, ddh.MaDat, kh.TenKH
from
	(select MaDat from DonDatHang
		except
		--union
		--intersect
	select MaDat from PhieuGiaoHang) as t1
	inner join DonDatHang as ddh on t1.MaDat=ddh.MaDat
	inner join KhachHang as kh on kh.MaKH = ddh.MaKH
	--c4: left join, tr144
	select ddh.MaDat, ddh.MaDat, kh.TenKH
	from DonDatHang as ddh
		left join PhieuGiaoHang as pgh on pgh.MaDat = ddh.MaDat
		inner join KhachHang as kh on kh.MaKH = ddh.MaKH
	where pgh.MaDat is null
--tên hàng hóa chưa ai mua
select *
from HangHoa as hh
	left join ChiTietDatHang as ctdh on ctdh.MaHH=hh.MaHH
where ctdh.MaHH is NULL
-- mặt hàng ai cũng có mua, phép chia, tự nghiên cứu
--THỐNG KÊ DỮ LIỆU, TR42
--1.1. TK trên toàn dữ liệu
select count(MaHH)
from HangHoa

select max(DonGiaHH)
from HangHoa

select max(SLCon)
from HangHoa
--1.2. TK theo vùng dữ liệu
select MaGiao,count(MaHH), max(DonGiaGiao)
from ChiTietGiaoHang
group by MaGiao

select MaHH, sum(SLGiao)
from ChiTietGiaoHang
group by MaHH
--c. Cho biết hàng hóa nào có đơn giá hiện hành cao nhất, hiển thị: tên hàng hóa, đơn giá 
--hiện hành.
select *
from HangHoa
where DonGiaHH = (select max(DonGiaHH)
				from HangHoa)
--d. Cho biết số lần đặt hàng của từng khách hàng, 
--những khách hàng không đặt hàng thì phải hiển thị số lần đặt hàng bằng 0. 
--Hiển thị: Mã khách hàng, tên khách hàng, số lần đặt
select kh.MaKH, SoLanDat = count(ddh.MaDat) 
from KhachHang as kh
	left join DonDatHang as ddh on kh.MaKH = ddh.MaKH
group by kh.MaKH
--e. Cho biết tổng tiền của từng phiếu giao hàng trong năm 2012,
--hiển thị: mã giao, ngày giao, tổng tiền, với tổng tiền= SUM(SLGiao*DonGiaGiao)
select ctgh.MaGiao, pgh.NgayGiao , TongTien = SUM(SLGiao * DonGiaGiao)
from ChiTietGiaoHang as ctgh
	inner join PhieuGiaoHang as pgh on ctgh.MaGiao = pgh.MaGiao
where year(pgh.NgayGiao) = 2012
group by ctgh.MaGiao, pgh.NgayGiao
--f. Cho biết khách hàng nào có 2 lần đặt hàng trở lên, hiển thị: mã khách hàng, tên khách 
--hàng, số lần đặt.
select MaKH, SoLanDat=count(MaDat)
from DonDatHang
group by MaKH
having count(MaDat) >=2  -- having, tr44
--g. Cho biết mặt hàng nào đã được giao với tổng số lượng giao nhiều nhất, hiển thị: mã 
--hàng, tên hàng hóa, tổng số lượng đã giao
select MaHH , tong = sum(SLGiao) from ChiTietGiaoHang
group by MaHH
having sum(SLGiao) >= all (select sum(SLGiao) from ChiTietGiaoHang
group by MaHH)

update HangHoa
set SLCon = SLCon + 10
where MaHH like 'M%'

select * into HangHoa_copy from HangHoa
select * from HangHoa_copy

delete from HangHoa_copy
where MaHH not in (select MaHH from ChiTietDatHang)

insert into HangHoa_copy
select * from HangHoa
where MaHH not in (select MaHH from ChiTietDatHang)
--j. Cập nhật số điện thoại cho khách hàng có mã KH006.
update KhachHang
set DienThoai='007'
where MaKH = 'KH006'
go
--k. Thêm cột ThanhTien cho bảng ChiTietGiaoHang, sau đó cập nhật giá trị cho cột này 
--với ThanhTien = SLGiao*DonGiaGiao
alter table chitietgiaohang
add thanhtien int

update ChiTietGiaoHang
set thanhtien = SLGiao * DonGiaGiao
go

select * from ChiTietGiaoHang
-----------------------------------------------------------------------

CREATE VIEW ThongKe
	AS 
		SELECT ChiTietGiaoHang.MaHH,ThanhTien = SUM(ChiTietGiaoHang.DonGiaGiao*ChiTietGiaoHang.SLGiao) 
			FROM ChiTietGiaoHang
				inner join PhieuGiaoHang on PhieuGiaoHang.MaGiao = ChiTietGiaoHang.MaGiao
			WHERE YEAR(PhieuGiaoHang.NgayGiao) = 2011 AND MONTH(PhieuGiaoHang.NgayGiao) <= 6
			GROUP BY  ChiTietGiaoHang.MaHH
			
DROP VIEW ThongKe			
				
SELECT *
	FROM ThongKe

 --- b 

CREATE VIEW ThongTinHangHoa
	AS	
		SELECT HangHoa.MaHH, HangHoa.TenHH, SUM(ChiTietDatHang.SLDat) as TongSLDat
			FROM HangHoa
				inner join ChiTietDatHang on ChiTietDatHang.MaHH = HangHoa.MaHH
			GROUP BY HangHoa.MaHH, HangHoa.TenHH
			HAVING sum(ChiTietDatHang.SLDat) >= all (select ChiTietDatHang.SLDat from ChiTietDatHang)

DROP VIEW ThongTinHangHoa

SELECT *
	FROM ThongTinHangHoa

-- C

CREATE VIEW KhachHangDN
	AS
		SELECT KhachHang.TenKH, KhachHang.DiaChi
			FROM KhachHang
			WHERE KhachHang.DiaChi = N'Đà Nẵng'
WITH CHECK OPTION

DROP VIEW KhachHangDN

SELECT *
	FROM KhachHangDN

-- D

CREATE VIEW vw_SoDonTheoNam
	AS
		SELECT YEAR(DH1.NgayDat) as Nam, COUNT(DH1.MaDat) as TongDonGiao, SoDonChuaGiao = (SELECT COUNT(DH2.MaDat)
																								FROM DonDatHang DH2
																									left join PhieuGiaoHang on PhieuGiaoHang.MaDat = DH2.MaDat
																								WHERE PhieuGiaoHang.NgayGiao is NULL 
																									AND YEAR(DH2.NgayDat) = YEAR(DH1.NgayDat))
			FROM DonDatHang DH1
				inner join PhieuGiaoHang on PhieuGiaoHang.MaDat = DH1.MaDat
			GROUP BY YEAR(DH1.NgayDat)

SELECT *
	FROM vw_SoDonTheoNam

--e. (*)Tạo view tính tổng số lượng mặt hàng “máy giặt” đã được đặt và được giao trong 
--năm 2012, hiển thị: mã mặt hàng, tên mặt hàng, tổng SL đặt, tổng SL giao.
create view vw_MayGiat2012
as
	select t1.MaHH, hh.TenHH, TongSLDat=sum(t1.SLDat),TongSLGiao=sum(t2.SLGiao)
	from
		(select ddh.MaDat, ddh.NgayDat, ctdh.MaHH, ctdh.SLDat
		from DonDatHang as ddh
			inner join ChiTietDatHang as ctdh on ddh.MaDat=ctdh.MaDat) as t1 --t1:bảng tổng số lượng đặt
	left join
		(select pgh.MaDat, ctgh.MaHH, ctgh.SLGiao
		from PhieuGiaoHang as pgh 
			inner join ChiTietGiaoHang as ctgh on ctgh.MaGiao=pgh.MaGiao) as t2 on t1.MaDat =t2.MaDat --t2: tổng số lượng giao
		inner join HangHoa as hh on t1.MaHH = hh.MaHH
	where hh.TenHH like N'Máy giặt%'
		and year(t1.NgayDat)=2012
	group by t1.MaHH, hh.TenHH


--f. (*)Loại khách hàng được phân theo thông tin sau:
--− Tổng tiền giao>= 50 triệu thì Loại khách hàng = “Khách hàng VIP”
--− Tổng tiền giao>= 20 triệu thì Loại khách hàng = “Khách hàng thân thiết”
--− Ngược lại thì Loại khách hàng = “Khách hàng thành viên”
--Tạo view hiển thị danh sách khách hàng cùng loại khách hàng tương ứng, hiển thị: Mã 
--khách hàng, tên khách hàng, địa chỉ, loại khách hàng

CREATE VIEW vw_KhachHangVIPPro
	AS
		SELECT KhachHang.TenKH, ThanhTien = (SUM(ChiTietGiaoHang.SLGiao * ChiTietGiaoHang.DonGiaGiao)), 'loai_khach' = CASE
			WHEN SUM(ChiTietGiaoHang.SLGiao * ChiTietGiaoHang.DonGiaGiao) >= 50000000 THEN 'Khach_VIP'
			WHEN SUM(ChiTietGiaoHang.SLGiao * ChiTietGiaoHang.DonGiaGiao) >= 30000000 THEN 'Khach_hoi_VIP'
			else 'Khach_jack'
		end
	FROM KhachHang
		inner join DonDatHang on DonDatHang.MaKH = KhachHang.MaKH
		inner join PhieuGiaoHang on PhieuGiaoHang.MaDat = DonDatHang.MaDat
		inner join ChiTietGiaoHang on ChiTietGiaoHang.MaGiao = PhieuGiaoHang.MaGiao
	GROUP BY KhachHang.TenKH
	
DROP VIEW vw_KhachHangVIPPro

SELECT *
	FROM vw_KhachHangVIPPro

	------------------
DECLARE @doanhThu int = 0
SET @doanhThu = (SELECT SUM(ChiTietGiaoHang.SLGiao * ChiTietGiaoHang.DonGiaGiao) 
					FROM ChiTietGiaoHang)
PRINT @doanhThu

----------
DECLARE @tenKhachHang nvarchar(50)
SET @tenKhachHang = (SELECT TOP 1 KhachHang.TenKH
						FROM KhachHang
							left join DonDatHang on DonDatHang.MaKH = KhachHang.MaKH
						WHERE DonDatHang.MaKH is NULL)
PRINT @tenKhachHang

------
DECLARE @tbl_TenKH table(
	tenKH nvarchar(50)
)
	INSERT INTO @tbl_TenKH
		SELECT  KhachHang.TenKH
			FROM KhachHang
				left join DonDatHang on DonDatHang.MaKH = KhachHang.MaKH
			WHERE DonDatHang.MaKH is NULL
SELECT * FROM @tbl_TenKH

--------
PRINT @@Version 
----------------------
DECLARE @maHH char(2) = 'BU'

IF EXISTS(SELECT * 
		FROM ChiTietDatHang 
		WHERE ChiTietDatHang.MaHH = @maHH)

		begin
			SELECT DISTINCT KhachHang.TenKH
				FROM KhachHang
					inner join DonDatHang on DonDatHang.MaKH = KhachHang.MaKH
				WHERE DonDatHang.MaDat IN ((SELECT ChiTietDatHang.MaDat 
												FROM ChiTietDatHang 
												WHERE ChiTietDatHang.MaHH = @maHH))
		end

ELSE

	begin
		DELETE FROM HangHoa WHERE HangHoa.MaHH = @maHH
	end

-------------------------
DECLARE @N int = 1, @tong int = 0

WHILE (@N <= 100)
	BEGIN 
		SET @tong = @tong + @N
		SET @N = @N + 1
	END

PRINT @tong
----------------
DECLARE @i int = 1, @ketQua varchar(500) = N'Kết quả: '

WHILE (@i <= 100)
	BEGIN 
		SET @ketQua = @ketQua + CAST(@i as varchar) + (CASE
															WHEN (@i % 10 = 0) THEN  CHAR(10)
															ELSE '  ' 
														END)
		SET @i = @i + 1
		
	END
PRINT @ketQua
------------------------------
--vd2: lấy MaKH tiếp theo trong dãy tăng liên tiếp
	--1. Khai báo biến @maKH='KH001', @stt=1
	--2. Lặp lại (5<6)
		--2.1. Kiểm tra @maKH có trong bảng KhachHang chưa?
			--Nếu có:
				--+ @stt=@stt+1
				--+ Tạo lập @maKH tiếp theo= 'KH' +(3-len(@stt)'0'+ @stt
			--Nếu không: 
				--+ in ra @maKH hiện tại
				--+ break: dừng vòng lặp

DECLARE @maKH char(5) = 'KH001', @stt int = 1

WHILE(1 = 1)
	BEGIN
		IF(@maKH in(SELECT MaKH FROM KhachHang))
			BEGIN
				SET @stt = @stt + 1
				--SET @maKH = 'KH' + CAST((CASE	WHEN (3-len(@stt) = 2) THEN '00'
				--								WHEN (3-len(@stt) = 1) THEN '0'
				--								ELSE ''
				--						END) as varchar(2)) + CAST(@stt as varchar(3))
				SET @maKH = 'KH' + REPLICATE('0', (3-len(@stt))) + CAST(@stt as varchar(3))
			END
		ELSE
			BEGIN
				PRINT @maKH
				BREAK
			END
	END

------------------ CURSOR --------
DECLARE cur_HH CURSOR 
	FORWARD_ONLY
FOR
	SELECT HangHoa.MaHH, HangHoa.TenHH FROM HangHoa
OPEN cur_HH  ---- Mo Con tro toi hang hoa --- required

DECLARE @maHH char(2), @tenHH nvarchar(50)
FETCH NEXT FROM cur_HH into @maHH, @tenHH
WHILE(@@FETCH_STATUS = 0)
	BEGIN
		PRINT @maHH + '-' + @tenHH
		FETCH NEXT FROM cur_HH into @maHH, @tenHH
	END

CLOSE cur_HH
DEALLOCATE cur_HH

--a. Thêm cột TongTien vào phiếu giao hàng, sau đó dùng con trỏ cập nhập giá trị cho cột 
--TongTien, với TongTien=SUM(SLGiao*DonGiaGiao) hay nói cách khác TongTien = SUM(ThanhTien).
	-- thêm cột TongTien vào PhieuGiaoHang
	alter table PhieuGiaoHang
	add
		TongTien int
	-- cập nhật TongTien
	declare cur_PGH cursor
		forward_only
	for
		SELECT MaGiao from PhieuGiaoHang
	--
	open cur_PGH
	--
	declare @maGiao char(5), @tongTien int
	fetch next from cur_PGH into @maGiao
	while(@@FETCH_STATUS=0)
	begin
		-- lấy TongTien của @maGiao
		set @tongTien = (select sum(ThanhTien)
						from ChiTietGiaoHang
						where MaGiao=@maGiao
						group by MaGiao)
		--cập nhật cột TongTien của PhieuGiaoHang
		update PhieuGiaoHang
		set TongTien=@tongTien
		where MaGiao=@maGiao
		-- 
		fetch next from cur_PGH into @maGiao
	end
	close cur_PGH
	deallocate cur_PGH
	-----------------------------------------------------------

	select * from PhieuGiaoHang
	select * from ChiTietGiaoHang

----------------
--b. Thêm mới cột KHUYENMAI_2012 vào bảng KHACHHANG để lưu giữ số tiền 
--khách hàng được khuyến mãi trong năm 2012. Dùng con trỏ để cập nhật giá trị cho cột này 
--như sau:
--- Khuyến mãi 3 triệu đối với khách mua hàng trên 50 triệu trong năm 2012
--- Khuyến mãi 2 triệu đối với khách hàng mua hàng trên 35 triệu trong năm 2012 và có 
--mua mặt hàng Máy giặt
--- Khuyến mãi 1 triệu đối với những khách hàng có mua hàng trong cả 2 năm 2012 và 
--2011.
--- Tiền khuyến mãi = 0 cho các trường hợp còn lại.
--Lưu ý là mỗi khách hàng chỉ nhận một mức tiền khuyến mãi cao nhất.

ALTER TABLE KhachHang
	ADD
		KHUYENMAI_2012 int
GO

SELECT * FROM KhachHang

DECLARE cur_KhuyenMai CURSOR
	FORWARD_ONLY
FOR SELECT KhachHang.MaKH FROM KhachHang

OPEN cur_KhuyenMai

DECLARE @maKH char(5)
fetch next from cur_KhuyenMai into @maKH

WHILE(@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @deal int = 0, @donGiaMua int = 0
			SET @donGiaMua = (SELECT SUM(ChiTietGiaoHang.thanhtien) FROM ChiTietGiaoHang
							inner join PhieuGiaoHang on ChiTietGiaoHang.MaGiao = PhieuGiaoHang.MaGiao
							inner join DonDatHang on PhieuGiaoHang.MaDat = DonDatHang.MaDat
						WHERE YEAR(DonDatHang.NgayDat) = 2012 AND DonDatHang.MaKH = @maKH)

						

			IF(@donGiaMua > 50000000)
				SET @deal = 3000000
			ELSE IF(@donGiaMua > 35000000 AND @maKH IN (SELECT DonDatHang.MaKH FROM ChiTietGiaoHang
																				inner join PhieuGiaoHang on ChiTietGiaoHang.MaGiao = PhieuGiaoHang.MaGiao
																				inner join DonDatHang on PhieuGiaoHang.MaDat = DonDatHang.MaDat
																				inner join HangHoa on HangHoa.MaHH = ChiTietGiaoHang.MaHH
																			WHERE YEAR(DonDatHang.NgayDat) = 2012 AND DonDatHang.MaKH = @maKH AND HangHoa.TenHH like N'%Máy Giặt%'))
				SET @deal = 2000000
			ELSE IF ( @maKH IN ( SELECT DonDatHang.MaKH FROM DonDatHang
										WHERE YEAR(DonDatHang.NgayDat) = 2011 
					 AND @maKH IN (SELECT DonDatHang.MaKH FROM DonDatHang
										WHERE YEAR(DonDatHang.NgayDat) = 2012)))
				SET @deal = 1000000
		UPDATE KhachHang
			SET KhachHang.KHUYENMAI_2012 = @deal
			WHERE KhachHang.MaKH = @maKH
		---
		fetch next from cur_KhuyenMai into @maKH
	END

CLOSE cur_KhuyenMai
DEALLOCATE cur_KhuyenMai
GO

SELECT * FROM KhachHang

-----------------------------------
CREATE PROC usp_TTMH
	@maKH char(5)
AS
BEGIN
	IF(@maKH is NULL OR @maKH = '')
		BEGIN
			PRINT 'NULL VALUES'
			RETURN
		END
	SELECT HangHoa.MaHH, HangHoa.TenHH, HangHoa.DonGiaHH, ChiTietDatHang.SLDat
		FROM DonDatHang
			inner join ChiTietDatHang on ChiTietDatHang.MaDat = DonDatHang.MaDat
			inner join HangHoa on HangHoa.MaHH = ChiTietDatHang.MaHH
		WHERE DonDatHang.MaKH = @maKH

END

DROP PROC usp_TTMH

EXEC usp_TTMH ''
GO

CREATE PROC usp_TongSLD
	@maHH char(2)
AS
BEGIN
	DECLARE @tong int = 0
	SET @tong =	(SELECT SUM(ChiTietDatHang.SLDat) 
					FROM ChiTietDatHang
						inner join DonDatHang on DonDatHang.MaDat = ChiTietDatHang.MaDat
					WHERE YEAR(DonDatHang.NgayDat) = '2012' AND ChiTietDatHang.MaHH = @maHH)
	RETURN @tong
END
DROP PROC usp_TongSLD

SELECT * FROM HangHoa

DECLARE @tongSL int = 0
EXEC @tongSL = usp_TongSLD 'BU'
PRINT @tongSL
GO

SELECT * FROM PhieuGiaoHang


---- B
CREATE PROC usp_TongTien
	@maGiao char(4)
AS
BEGIN
	DECLARE @tongTien int = 0
	SELECT @tongTien = SUM(PhieuGiaoHang.TongTien) 
		FROM PhieuGiaoHang 
		WHERE PhieuGiaoHang.MaGiao = @maGiao
	RETURN @tongTien
END 

DECLARE @tongTien int = 0
EXEC @tongTien = usp_TongTien 'GH01'

PRINT @tongTien


----C

SELECT * FROM DonDatHang

CREATE PROC usp_TTDatHang
	@maKH char(5)
AS
BEGIN
	SELECT DonDatHang.MaDat, DonDatHang.NgayDat, PhieuGiaoHang.MaGiao, PhieuGiaoHang.NgayGiao
		FROM DonDatHang
			inner join PhieuGiaoHang on PhieuGiaoHang.MaDat = DonDatHang.MaDat
		WHERE DonDatHang.MaKH = @maKH
END

DECLARE @maKH char(5) = 'KH003'

EXEC usp_TTDatHang @maKH


----

CREATE PROC usp_ThemHH
	@maHH char(5), @tenHH nvarchar(50), @DVT nvarchar(20), @SL int, @donGia int
AS
BEGIN
	IF	(EXISTS(SELECT HangHoa.MaHH FROM HangHoa WHERE HangHoa.MaHH = @maHH) OR @maHH is NULL)
		BEGIN
			RAISERROR(N'Loi',16,1)
			PRINT N'Ma HH khong hop le'
			RETURN
		END
	IF (EXISTS(SELECT HangHoa.TenHH FROM HangHoa WHERE HangHoa.TenHH = @tenHH) OR @tenHH is NULL)
		BEGIN
			PRINT N'Ten hang hoa khong hop le'
			RETURN
		END
	IF (@SL <= 0 OR @tenHH is NULL)
		BEGIN
			PRINT N'Sl phai lon hon 0'
			RETURN
		END
	IF (@donGia <= 0 OR @donGia is NULL)
		BEGIN
			PRINT N'Don gia phai lon hon 0'
			RETURN
		END

	INSERT INTO HangHoa(MaHH, TenHH, SLCon, DVT, DonGiaHH)
			VALUES (@maHH, @tenHH, @SL, @DVT, @donGia)
END
--
DROP PROC usp_ThemHH

DECLARE @maHH char(5), @tenHH nvarchar(50), @DVT nvarchar(20), @SL int, @donGia int

EXEC usp_ThemHH NULL, N'TEST4', N'Cai', 5,NULL
--EXEC usp_ThemHH @maHH, @tenHH, @DVT, @SL, @donGia

SELECT * FROM HangHoa

---------------F
ALTER PROC usp_ThemCTGH
	@maGiao char(5), @maHH char(5), @SLGiao int
AS
BEGIN
	IF EXISTS (SELECT * FROM ChiTietGiaoHang WHERE MaGiao = @maGiao) 
		BEGIN
			PRINT 'Da co don hang'
			RETURN 
		END
	IF NOT EXISTS(SELECT * FROM ChiTietDatHang WHERE ChiTietDatHang.MaHH = @maHH)
		BEGIN
			RAISERROR(N'Loi',16,1)
			PRINT N'KHONG CO AI DAT HH NAY'
			RETURN
		END
	IF	@SLGiao > (SELECT SUM(ChiTietDatHang.SLDat) FROM ChiTietDatHang WHERE ChiTietDatHang.MaHH = @maHH)
		BEGIN 
			PRINT 'ERRORRRR'
			RETURN
		END
	IF @SLGiao > (SELECT SUM(HangHoa.SLCon) FROM HangHoa WHERE HangHoa.MaHH = @maHH)
		BEGIN
			PRINT 'ERROR'
			RETURN
		END
	--
	BEGIN TRAN 
		BEGIN TRY
			DECLARE @donGiaGiao int
			SET @donGiaGiao = (SELECT SUM(HangHoa.DonGiaHH) FROM HangHoa WHERE MaHH = @maHH)
			INSERT INTO ChiTietGiaoHang (MaGiao, MaHH, SLGiao, DonGiaGiao)
					VALUES (@maGiao, @maHH, @SLGiao, @donGiaGiao)
			UPDATE HangHoa 
				SET HangHoa.SLCon = SLCon - @SLGiao
		END TRY 
		BEGIN CATCH
			RAISERROR(N'Loi fsfsf ',16,1)
				ROLLBACK TRAN
				RETURN
		END CATCH
		
	COMMIT TRAN
END
---
SELECT * FROM ChiTietDatHang
SELECT * FROM ChiTietGiaoHang

DECLARE @maGiao char(5) = 'GH07', @maHH char(5) = 'TL', @SLGiao int = 1
EXEC usp_ThemCTGH @maGiao, @maHH, @SLGiao
------------
----Functions
--a

CREATE FUNCTION usf_MaKH()
	RETURNS char(5)
AS
BEGIN
	DECLARE @maKH char(5) = 'KH001', @stt int = 1
	WHILE(1 = 1)
	BEGIN
		IF(@maKH in(SELECT MaKH FROM KhachHang))
			BEGIN
				SET @stt = @stt + 1
				--SET @maKH = 'KH' + CAST((CASE	WHEN (3-len(@stt) = 2) THEN '00'
				--								WHEN (3-len(@stt) = 1) THEN '0'
				--								ELSE ''
				--						END) as varchar(2)) + CAST(@stt as varchar(3))
				SET @maKH = 'KH' + REPLICATE('0', (3-len(@stt))) + CAST(@stt as varchar(3))
			END
		ELSE
			BEGIN
				RETURN @maKH
			END
	END 
	RETURN 0
END

SELECT* FROM KhachHang
PRINT dbo.usf_MaKH()
--------
--B
ALTER FUNCTION usf_DonHang(@maDat char(5))
	RETURNS nvarchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM DonDatHang WHERE MaDat = @maDat) RETURN 'Ko co don dat hang nay'
	
	IF NOT EXISTS(SELECT * FROM PhieuGiaoHang WHERE PhieuGiaoHang.MaDat = @maDat)  RETURN 'Chua giao'
	
	RETURN 'Da giao'
END

SELECT * FROM DonDatHang
PRINT dbo.usf_DonHang('DH01')
------------
ALTER FUNCTION usf_TongTienGiao(@maKH char(5), @nam int)
	RETURNS int
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM KhachHang WHERE MaKH = @maKH) RETURN 0
	RETURN (SELECT SUM(ChiTietGiaoHang.thanhtien)
				FROM DonDatHang 
					inner join PhieuGiaoHang on PhieuGiaoHang.MaDat = DonDatHang.MaDat
					inner join ChiTietGiaoHang on ChiTietGiaoHang.MaGiao = PhieuGiaoHang.MaGiao
			WHERE DonDatHang.MaKH = @maKH AND YEAR(PhieuGiaoHang.NgayGiao) = @nam)
END

SELECT * FROM PhieuGiaoHang 
PRINT dbo.usf_TongTienGiao('KH005', 2012)