create database QLBH_NGUYENVANKHANH

go 

use QLBH_NGUYENVANKHANH

go 

create table HOADON(
	soHD int primary key identity(1,1),
	ngayHD datetime,
	tenKH nvarchar(50),
	diachi nvarchar(50),
	dienthoai varchar(11)
	)

	go

create table HANG(
	mahang varchar(10) primary key,
	tenhang nvarchar(50),
	donvitinh nvarchar(10),
	dongia float,
	soluong int
	)
	go

create table CHITIETHD(
	soHD int,
	mahang varchar(10),
	giaban float,
	soluong int,
	mucgiamgia float,
	constraint PK_soHD_mahang primary key(soHD,mahang)
	)
	go
drop table HANG
alter table CHITIETHD add constraint FK_soHD foreign key (soHD) references HOADON(soHD)
alter table CHITIETHD add constraint FK_mahang foreign key (mahang) references HANG(mahang)

---3 nhập dữ liệu vào các bảng trên mỗi bảng ghi ít nhất 3 bản ghi
go 
-- Chèn dữ liệu vào bảng HOADON
	INSERT INTO HOADON (ngayHD, tenKH, diachi, dienthoai) VALUES
	('2023-01-01', N'Nguyễn Văn Khánh', N'Hà Nội', '1234567890'),
	('2023-01-02', N'Phan Minh Khoa', N'Hà Nội', '9876543210'),
	('2023-01-03', N'Đinh Xuân Hiếu', N'Gia Lâm', '1112223333'),
	('2023-01-04', N'Nguyễn Minh Hiếu', N'Hà Nam', '4445556666'),
	('2023-01-01', N'Nguyễn Văn Trung', N'Quốc Oai', '1234567890'),
	('2023-01-05', N'Tạ Đức Dũng', N'Hà Tây', '7778889999');

	INSERT INTO HOADON (ngayHD, tenKH, dienthoai) VALUES
('2019-09-01', 'Khách hàng A', '1234567890'),
('2019-09-05', 'Khách hàng B', '9876543210'),
('2019-09-10', 'Khách hàng C', '1112223333'),
('2019-09-15', 'Khách hàng D', '4445556666'),
('2019-09-20', 'Khách hàng E', '7778889999');
go 
-- chèn dữ liệu vào bảng HANG
	INSERT INTO HANG (mahang, tenhang, donvitinh, dongia, soluong) VALUES
	('MH001', N'Hàng hóa 1', N'Cái', 100.0, 50),
	('MH002', N'Hàng hóa 2', N'Chiếc', 150.0, 30),
	('MH003', N'Hàng hóa 3', N'Bộ', 200.0, 20),
	('MH004', N'Hàng hóa 4', N'Hộp', 80.0, 100),
	('MH005', N'Hàng hóa 5', N'Cây', 120.0, 40);
go
-- chèn dữ liệu vào bảng CHITIETHD
	INSERT INTO CHITIETHD (soHD, mahang, giaban, soluong, mucgiamgia) VALUES
	(1, 'MH001', 120.0, 2, 10.0),
	(1, 'MH002', 150.0, 1, 5.0),
	(2, 'MH003', 200.0, 3, 15.0),
	(3, 'MH002', 150.0, 2, 0.0),
	(4, 'MH004', 80.0, 5, 20.0),
	(5, 'MH001', 120.0, 1, 8.0);
-- 4, cho biết thông tin khách đã từng mua hàng ở các địa chỉ đã bắt đầu bằng chũ 'Hà'.
select HOADON.soHD,
		HOADON.tenKH,
		HOADON.diachi,
		HOADON.dienthoai 
from HOADON,CHITIETHD,HANG
where HOADON.soHD = CHITIETHD.soHD and HANG.mahang = CHITIETHD.mahang and HOADON.diachi like N'Hà%'
--5 cho biết thông tin về hàng hóa có đơn giá nhỏ nhất đã bán trong tháng 9 năm 2019
SELECT TOP 1 HANG.mahang, HANG.tenhang, HANG.donvitinh, HANG.dongia
FROM HANG
INNER JOIN CHITIETHD ON HANG.mahang = CHITIETHD.mahang
INNER JOIN HOADON ON CHITIETHD.soHD = HOADON.soHD
WHERE MONTH(HOADON.ngayHD) = 9 AND YEAR(HOADON.ngayHD) = 2019
ORDER BY HANG.dongia ASC;
--6 với mỗi mặt hàng , đếm số lượng đã bán được 
SELECT HANG.mahang, HANG.tenhang, SUM(CHITIETHD.soluong) AS SoLuongDaBan
FROM HANG
LEFT JOIN CHITIETHD ON HANG.mahang = CHITIETHD.mahang
GROUP BY HANG.mahang, HANG.tenhang
ORDER BY HANG.mahang;

--7 
CREATE VIEW View_400 AS
SELECT HANG.tenhang, HANG.dongia, SUM(CHITIETHD.soluong) AS SoLuongBanDuoc
FROM HANG
INNER JOIN CHITIETHD ON HANG.mahang = CHITIETHD.mahang
WHERE HANG.dongia > 300
GROUP BY HANG.tenhang, HANG.dongia;
--8
CREATE PROCEDURE GetCustomerNAME
    @tenKH nvarchar(20)
AS
BEGIN
    SELECT HOADON.soHD, HOADON.ngayHD, HOADON.tenKH, HOADON.diachi, HOADON.dienthoai,
           CHITIETHD.mahang, HANG.tenhang, CHITIETHD.giaban, CHITIETHD.soluong, CHITIETHD.mucgiamgia
    FROM HOADON
    INNER JOIN CHITIETHD ON HOADON.soHD = CHITIETHD.soHD
    INNER JOIN HANG ON CHITIETHD.mahang = HANG.mahang
    WHERE HOADON.tenKH = @tenKH;
END;