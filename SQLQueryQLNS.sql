create database QLNS

go 

use QLNS

go 

create table NHANVIEN(
	MaNV varchar(5) primary key,
	HoTen nvarchar(20),
	GT nvarchar(10),
	NS date check(NS <getdate()),
	QQ nvarchar(50),
	DT char(11),
	MaPB varchar(5),
	foreign key (MaPB) references PHONGBAN(MaPB)
	)
go

create table PHONGBAN(
	MaPB varchar(5) primary key ,
	TenPB nvarchar(20),
	DienThoai char(11)
	)

	go
create table CHUCVU(
	MaCV varchar(5) primary key,
	TenCV nvarchar(20) check(TenCV in ('GĐ','PGD','TP','PP','NV')),
	HSPC float check (HSPC between 0.4 and 1.2),
	)
	go
create table BACLUONG(
	MaBL varchar(5) primary key,
	HSL float default(2.54) check(HSL between 2.54 and 12),
	HSPC float check (HSPC between 0.4 and 1.2)
	)
	go
create table DC_PB(
	MaPB varchar(5) foreign key references PHONGBAN(MaPB),
	DiaChi nvarchar(20),
	constraint PK_KHOA primary key(MaPB,DiaChi)
	)
	go
create table NV_CHUCVU(
	MaNV varchar(5),
	MaCV varchar(5),
	NgayQD date)
go
alter table NV_CHUCVU add constraint FK_MaNV foreign key (MaNV) references NHANVIEN(MaNV)
alter table NV_CHUCVU add constraint FK_MaCV foreign key (MaCV) references CHUCVU(MaCV)