create database QL_CanBo;

go

use QL_CanBo;

go 

create table PhongBan(
	MaPB varchar(10) primary key,
	TenPB nvarchar(50) not null,
	ChucNang nvarchar(100)
	)
go

create table CanBo(
	MaCB varchar(10) primary key,
	MaPB varchar(10),
	HoTen nvarchar(50) not null,
	NgaySinh Date,
	GioiTinh nvarchar(4) check(GioiTinh in (N'Nam',N'N?')),
	QueQuan nvarchar(50),
	)

	go

	alter table CanBo add constraint FK_MaPB foreign key (MaPB) references PhongBan(MaPB);

