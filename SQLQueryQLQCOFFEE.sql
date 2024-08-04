-- Qu?n lý quán cà coffee

create database QL_COFFEE

go 

use QL_COFFEE
go

create table KHACHHANG(
	makhachhang int primary key identity(1,1),
	hotendem nvarchar(50) not null,
	ten nvarchar(50) not null,
	email nvarchar(100),
	dienthoai nvarchar(20),
	ghichu nvarchar(max)
	)
go

create table SANPHAM(
	masanpham int primary key identity(1,1),
	tensanpham nvarchar(255) not null,
	danhmuc nvarchar(50), 
	gia decimal(10,2) not null,
	soluongtrongkho int not null
	)

	go

create table DONHANG(
	madonhang int primary key identity(1,1),
	makhachhang int,
	ngaydathang date not null,
	trangthai nvarchar(50) not null
	)

	go

create table ban(
	maban int primary key identity(1,1),
	khuvuc nvarchar(50) not null,
	trangthai nvarchar(50) not null,
	makhachhang int 
	)

	go

create table CHITIETDONHANG(
	machitietdonhang int primary key identity(1,1),
	madonhang int,
	masanpham int,
	soluong int,
	gia decimal(10,2)
	)

	go 
create table THANHTOAN(
	mathanhtoan int primary key identity(1,1),
	madonhang int,
	ngaythanhtoan date not null,
	sotienthanhtoan decimal(10,2) not null,
	phuongthucthanhtoan nvarchar(50) not null
	)

	go 
create table NHANVIEN(
	manhanvien int primary key identity(1,1),
	hotendem nvarchar(50) not null,
	ten nvarchar(50) not null,
	CMND nvarchar(20) not null,
	ngaysinh date,
	gioitinh nvarchar(10),
	dienthoai varchar(20),
	giolamviec int
	)

	go
create table TAIKHOAN(
	mataikhoan int primary key identity(1,1),
	tendangnhap nvarchar(50) not null,
	matkhau nvarchar(255) not null,
	quyentruycap bit,
	manhanvien int
	)
	go

create table KHUYENMAI(
	makhuyenmai int primary key identity(1,1),
	tenkhuyenmai nvarchar(100) not null,
	giamgia decimal(5,2) not null,
	)

	go
create table SANPHAMKHUYENMAI(
	masanpham int,
	makhuyenmai int,
	primary key(masanpham,makhuyenmai)
	)
	go
		

	alter table TAIKHOAN add constraint FK_taikhoan_manhanvien foreign key (manhanvien) references NHANVIEN(manhanvien)
	alter table SANPHAMKHUYENMAI add constraint FK_sanphamkhuyenmai_makhuyenmai foreign key (makhuyenmai) references KHUYENMAI(makhuyenmai)
	alter table SANPHAMKHUYENMAI add constraint FK_sanphamkhuyenmai_masanpham foreign key (masanpham) references SANPHAM(masanpham)
	alter table CHITIETDONHANG add constraint FK_chitietdonhang_madonhang foreign key (madonhang) references DONHANG(madonhang) 
	alter table CHITIETDONHANG add constraint FK_chitietdonhang_masanpham foreign key (masanpham) references SANPHAM(masanpham)
	alter table DONHANG add constraint FK_donhang_khachhang foreign key(makhachhang) references KHACHHANG(makhachhang)
	alter table THANHTOAN add constraint FK_thanhtoan_donhang foreign key(madonhang) references DONHANG(madonhang)
	alter table BAN add constraint FK_ban_makhachhang foreign key (makhachhang) references KHACHHANG(makhachhang)
	
 