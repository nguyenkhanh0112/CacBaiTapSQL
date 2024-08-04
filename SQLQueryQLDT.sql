create database QLDT;

go 

use QLDT;

go 

create table SinhVien(
	MaSV varchar(10) primary key,
	TenSV nvarchar(50) not null,
	NgaySinh Datetime,
	GioiTinh nvarchar(4),
	QueQuan nvarchar(50)
	)

go

create table DeTai(
	MaDT varchar(10) primary key,
	TenDT nvarchar(50) not null
	)
go

create table GiaoVien(
	MaGV varchar(10) primary key,
	TenGV nvarchar(50) not null,
	QueQuan nvarchar(50)
	)
go

insert into SinhVien (MaSV,TenSV,NgaySinh,GioiTinh,QueQuan)
	values 
	('SV01',N'Nguyễn Thị Diệu','1990/02/18',N'Nữ',N'Quảng Ninh'),
	('SV02',N'Trần Thị Khuyên','1990/11/16',N'Nữ',N'Hải Dương'),
	('SV03',N'Định Thị Ngân','1990/07/16',N'Nữ',N'Nam Đinh');

	go 
insert into DeTai (MaDT,TenDT) values
	('DT01',N'Xây dựng phần mềm quản lí bán sách'),
	('DT02',N'Xây dựng phần mềm quản lí hiệu thuốc'),
	('DT03',N'Xây dựng websites quản lí bán điện thoại di động trực tuyến');

	alter table Sinhvien
	alter column NgaySinh date 

	alter table DeTai
	alter column TenDT nvarchar(200)

	select * from DeTai

	sp_help SinhVien


	go 

	create table SinhVien_DeTai(
		MaSV varchar(10),
		MaDT varchar(10),
		constraint PK_MaSV_MaDT primary key(MaSV,MaDT)
		)
	alter table SinhVien_DeTai add
		constraint FK_MaSV foreign key(MaSV) references SinhVien(MaSV);
	alter table SinhVien_DeTai add
		constraint FK_MaDT foreign key(MaDT) references DeTai(MaDT);

	create table KetQua(
		MaSV varchar(10),
		MaDT varchar(10),
		Diem nvarchar(50)
		constraint PK_MaSV_MaDT_KQ primary key(MaSV,MaDT)
		)

	alter table KetQua add constraint FK_MaSV_KQ foreign key (MaSV) references SinhVien(MaSv);
	alter table KetQua add constraint FK_MaDT_KQ foreign key (MaDT) references DeTai(MaDT)


	insert into KetQua(MaSV,MaDT,Diem) values 
		('SV01' ,'DT01',9),
		('SV02','DT01',9),
		('SV03','DT03',8);

	alter table KetQua
	alter column Diem int;
	alter table KetQua
	add constraint CK_DiemRange check(Diem between 0 and 10);
	 select * from KetQua

	 sp_helpconstraint KetQua














	