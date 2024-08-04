create database QLDIEM

go

use QLDIEM

go

create table Lop(
	MaLop nvarchar(20) primary key,
	TenLop nvarchar(20),
	Siso int
	)
go

create table Sinhvien(
	MaSV nvarchar(10) primary key,
	TenSV nvarchar(30),
	NamSinh Date,
	GioiTinh nvarchar(10) check (GioiTinh in (N'Nam',N'Nữ')),
	MaLop nvarchar(20)
	)
go

create table MonHoc(
	MaMon nvarchar(20) primary key,
	TenMon nvarchar(30),
	Sotinchi int
	)
go
create table Diem(
	MaSV nvarchar(10),
	MaMon nvarchar(20),
	ketqua float,
	Lanthi int,
	)
go 
alter table Diem 
alter column MaMon nvarchar(20) not null
alter table Sinhvien add constraint FK_SinhVien_Lop foreign key (MaLop) references Lop(MaLop)
alter table Diem add constraint PK_MaSV_MaMon primary key (MaSV,MaMon) 
alter table Diem add constraint FK_MaMon foreign key(MaMon) references MonHoc(MaMon)
alter table Diem add constraint FK_MaSV foreign key (MaSV) references Sinhvien(MaSV)

go 
-- Chèn dữ liệu cho bảng Lop
insert into Lop(MaLop, TenLop, Siso) values
    (N'L01', N'Lớp 01', 30),
    (N'L02', N'Lớp 02', 25),
    (N'L03', N'Lớp 03', 28),
    (N'L04', N'Lớp 04', 32),
    (N'L05', N'Lớp 05', 27);

go
INSERT INTO Sinhvien (MaSV, TenSV, NamSinh, GioiTinh, MaLop) 
VALUES 
(N'SV001', N'Nguyễn Văn A', '1998-05-15', N'Nam',N'L01'),
(N'SV002', N'Trần Thị B', '1999-02-20', N'Nữ', N'L02'),
(N'SV003', N'Lê Văn C', '1997-11-10', N'Nam', N'L01'),
(N'SV004', N'Phạm Thị D', '1998-09-25', N'Nữ', N'L03'),
(N'SV005', N'Hoàng Văn E', '1996-07-30', N'Nam',N'L02'),
(N'SV006', N'Nguyễn Thị F', '1999-03-05', N'Nữ', N'L03'),
(N'SV007', N'Lý Văn G', '1997-12-12', N'Nam', N'L01'),
(N'SV008', N'Trần Thị H', '1998-08-18', N'Nữ', N'L02'),
(N'SV009', N'Đỗ Văn I', '1996-06-22', N'Nam', N'L01'),
(N'SV010', N'Phan Thị K', '1999-04-08', N'Nữ', N'L03'),
(N'SV011', N'Nguyễn Văn L', '1997-10-17', N'Nam', N'L02'),
(N'SV012', N'Trần Thị M', '1998-07-14', N'Nữ', N'L01'),
(N'SV013', N'Vũ Văn N', '1996-11-30', N'Nam', N'L03'),
(N'SV014', N'Lê Thị P', '1999-01-25', N'Nữ', N'L02'),
(N'SV015', N'Mai Văn Q', '1997-09-10', N'Nam', N'L01');

INSERT INTO MonHoc (MaMon, TenMon, Sotinchi)
VALUES
    (N'MH001', N'Toán Cao Cấp', 3),
    (N'MH002', N'Mạng Máy Tính', 3),
    (N'MH003', N'Tin Đại Cương', 4),
    (N'MH004', N'Lập Trình Cơ Bản', 3),
    (N'MH005', N'Cơ Sở Dữ Liệu', 4);


go
INSERT INTO Diem (MaSV, MaMon, Ketqua, Lanthi)
VALUES
    (N'SV001', N'MH001', 8, 1),
    (N'SV001', N'MH002', 5, 1),
    (N'SV001', N'MH003', 7, 1),
	(N'SV001', N'MH004', 7, 1),
	(N'SV001', N'MH005', 7, 1),
    (N'SV002', N'MH001', 9, 1),
    (N'SV002', N'MH002', 5, 2),
    (N'SV002', N'MH003', 2, 1),
	(N'SV002', N'MH004', 10, 1),
	(N'SV002', N'MH005', 8.5, 2),
    (N'SV003', N'MH001', 4, 1),
    (N'SV003', N'MH002', 2, 1),
	(N'SV003', N'MH004', 2, 1),
	(N'SV003', N'MH005', 4, 2),
    (N'SV004', N'MH001', 1, 1),
    (N'SV004', N'MH002', 3, 1),
	(N'SV005', N'MH004', 2, 1),
	(N'SV005', N'MH005', 3, 2),
    (N'SV005', N'MH001', 4, 1),
    (N'SV006', N'MH001', 2, 1),
    (N'SV006', N'MH002', 7, 1),
    (N'SV006', N'MH003', 9, 1),
	(N'SV006', N'MH004', 8, 1),
	(N'SV006', N'MH005', 8, 1),
    (N'SV007', N'MH001', 4, 1),
    (N'SV007', N'MH002', 5, 1),
    (N'SV007', N'MH003', 8, 1),
	(N'SV007', N'MH004', 1, 1),
	(N'SV007', N'MH005', 2, 2),
    (N'SV008', N'MH001', 9, 1),
    (N'SV008', N'MH002', 8, 1),
    (N'SV009', N'MH001', 7, 1),
    (N'SV009', N'MH002', 7, 1),
    (N'SV009', N'MH003', 5, 1),
    (N'SV010', N'MH001', 3, 1),
    (N'SV010', N'MH003', 6, 1),
	(N'SV009', N'MH004', 7, 1),
    (N'SV009', N'MH005', 5, 1),
    (N'SV011', N'MH001', 6, 1),
	(N'SV011', N'MH004', 6, 1),
	(N'SV011', N'MH005', 6, 2),
    (N'SV012', N'MH001', 8, 1),
    (N'SV012', N'MH002', 7, 1),
    (N'SV012', N'MH004', 5, 1),
	(N'SV012', N'MH005', 9.5, 1),
    (N'SV012', N'MH003', 5, 1),
    (N'SV013', N'MH001', 6, 1),
    (N'SV013', N'MH002', 5, 1),
    (N'SV013', N'MH003', 5, 1),
	(N'SV013', N'MH004', 8, 1),
    (N'SV013', N'MH005', 2, 1),
    (N'SV014', N'MH001', 8, 1),
    (N'SV014', N'MH002', 9, 2),
    (N'SV014', N'MH003', 7, 1),
	(N'SV014', N'MH004', 9, 1),
    (N'SV014', N'MH005', 7, 2),
    (N'SV015', N'MH001', 3, 1),
    (N'SV015', N'MH002', 6, 1),
    (N'SV015', N'MH003', 4, 1),
	(N'SV015', N'MH004', 6, 1),
    (N'SV015', N'MH005', 4, 2);
 
 go
