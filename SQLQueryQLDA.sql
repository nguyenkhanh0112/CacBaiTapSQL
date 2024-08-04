create database QLDA

go 

use QLDA 

go

create table NHANVIEN(
	MANV nvarchar(9) primary key,
	HONV nvarchar(15),
	TENLOT nvarchar(15),
	TENNV nvarchar(15),
	NGSINH date,
	DCHI nvarchar(30),
	PHAI nvarchar(3) check (PHAI in (N'Nam',N'Nữ')),
	LUONG float,
	MA_NQL nvarchar(9),
	PHG int
	)
go
create table DEAN(
	MADA int primary key,
	TENDA nvarchar(15),
	DDIEM_DA nvarchar(15),
	PHONG int
	)
go
create table CONGVIEC(
	MADA int,
	STT int,
	TEN_CONG_VIEC nvarchar(50),
	constraint PK_MADA_STT primary key (MADA,STT),
	)
go
create table PHONGBAN(
	MAPHG int primary key,
	TENPHG nvarchar(15),
	TRPHG nvarchar(9),
	NG_NHANCHUC date
	)
go
create table DIADIEM_PHG(
	MAPHG int,
	DIADIEM nvarchar(15),
	constraint PK_MAPHG_DIADIEM primary key(MAPHG,DIADIEM)
	)
go 
create table PHANCONG(
	MA_NVIEN nvarchar(9),
	MADA int,
	STT int,
	THOIGIAN float,
	constraint PK_MANVIEN_MADA_STT primary key(MA_NVIEN,MADA,STT)
	)
go 
create table THANNHAN(
	MA_NVIEN nvarchar(9),
	TENTN nvarchar(15),
	PHAI nvarchar(3) check (PHAI in (N'NAM',N'NỮ')),
	NGSINH date,
	QUANHE nvarchar(15),
	constraint PK_MANVIEN_TENTN primary key(MA_NVIEN,TENTN)
	)
go

alter table NHANVIEN add constraint FK_MAPHG_PHG foreign key (PHG) references PHONGBAN(MAPHG);
alter table DEAN add constraint FK_PHONG_MAPHG foreign key(PHONG) references PHONGBAN(MAPHG);
alter table DIADIEM_PHG add constraint FK_MAPHGPB_MAPHG foreign key(MAPHG) references PHONGBAN(MAPHG);
alter table CONGVIEC add constraint FK_MADACV_MADADA foreign key(MADA) references DEAN(MADA);
alter table PHANCONG add constraint FK_MA_NVIEN_MANV foreign key(MA_NVIEN) references NHANVIEN(MANV);
alter table THANNHAN add constraint FK_MA_NVIEN_MANV foreign key (MA_NVIEN) references NHANVIEN(MANV);
alter table PHANCONG add constraint FK_MADAPC_MADACV_STT foreign key(MADA,STT) references CONGVIEC(MADA,STT);
go
sp_helpconstraint nhanvien

alter table THANNHAN add constraint PK_MANVIEN_TENTN primary key(MA_NVIEN,TENTN) ;
alter table PHANCONG add constraint  PK_MANVIEN_MADA_STT primary key(MA_NVIEN,MADA,STT);
ALTER TABLE NHANVIEN ADD CONSTRAINT PK_NHANVIEN PRIMARY KEY (MaNV);
alter table NHANVIEN alter column MANV nvarchar(9) not null

select * from NHANVIEN
go
insert into NHANVIEN(MANV,HONV,TENLOT,TENNV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG) values('009',N'Đinh',N'Bá',N'Tiên','1960-02-11',N'119 Cống Quỳnh,TP HCM',N'Nam',30000,'005',5),
																					('005',N'Nguyễn',N'Thạch',N'Tùng','1962-08-20',N'222 Cống Nguyễn Văn Cừ,Tp HCM',N'Nam',40000,'006',5),
																					('007',N'Đinh',N'Bá',N'Tiên','1960-02-11',N'332 Nguyễn Thái Học,Tp HCM',N'Nam',25000,'001',4),
																					('001',N'Đinh',N'Bá',N'Tiên','1960-02-11',N'201 Hồ Văn Huê,TpHCM',N'Nữ',43000,'006',4),
																					('004',N'Đinh',N'Bá',N'Tiên','1960-02-11',N'92 Bà Rịa,Vũng Tàu',N'Nam',38000,'005',5),
																					('003',N'Đinh',N'Bá',N'Tiên','1960-02-11',N'34 Mai Thị Lự,TP HCM',N'Nam',25000,'005',5),
																					('008',N'Đinh',N'Bá',N'Tiên','1960-02-11',N'80 Lê Hồng Phong,TP HCM',N'Nam',25000,'001',4),
																					('006',N'Đinh',N'Bá',N'Tiên','1960-02-11',N'45 Trưng Vương,Hà Nội',N'Nữ',55000,'',1);
go

select * from PHONGBAN
go
insert into PHONGBAN(MAPHG,TENPHG,TRPHG,NG_NHANCHUC) values(5,N'Nghiên Cứu',N'005','1978-05-22'),
															(4,N'Điều hành',N'008','1985-01-01'),
															(1,N'Quản lý',N'006','1971-06-19');
		go
		select * from THANNHAN
		insert into THANNHAN(MA_NVIEN,TENTN,PHAI,NGSINH,QUANHE) values (N'005',N'Trinh',N'Nữ','1976-04-05',N'Con gái'),
																		(N'005',N'Khang',N'Nam','1973-10-25',N'Contrai'),
																		(N'005',N'Phương',N'Nữ','1948-05-03',N'Vợ chồng'),
																		(N'001',N'Minh',N'Nam','1932-02-29',N'Vợ chồng'),
																		(N'009',N'Tiến',N'Nam','1978-01-01',N'Con trai'),
																		(N'009',N'Châu',N'Nữ','1978-12-30',N'Con gái'),
																		(N'009',N'Phương',N'Nữ','1957-05-05',N'Vợ Chồng');
go

select * from DEAN
insert into DEAN(MADA,TENDA,DDIEM_DA,PHONG) values(1,N'Sản phẩm X',N'Vũng Tàu',5),
												(2,N'Sản phẩm X',N'Nha Trang',5),
												(3,N'Sản phẩm X',N'TP HCM',5),
												(10,N'Sản phẩm X',N'Hà Nội',4),
												(20,N'Sản phẩm X',N'TP HCM',1),
												(30,N'Sản phẩm X',N'Hà Nội',4);
go
select * from DIADIEM_PHG

insert into DIADIEM_PHG(MAPHG,DIADIEM) values(1,N'TP HCM'),
											(4,N'Hà Nội'),
											(5,N'TAU'),
											(5,N'NHA TRANG'),
											(5,N'TP HCM');
go

select * from PHANCONG
insert into PHANCONG(MA_NVIEN,MADA,STT,THOIGIAN) values (N'009',1,1,32),
														(N'009',2,2,8),
														(N'004',3,1,40),
														(N'003',1,2,20.0),
														(N'003',2,1,20.0),
														(N'008',10,1,35),
														(N'008',30,2,5),
														(N'001',30,1,20),
														(N'001',20,1,15),
														(N'006',20,1,30),
														(N'005',3,1,10),
														(N'005',10,2,10),
														(N'005',20,1,10),
														(N'007',30,2,30),
														(N'007',10,2,10);
go
select * from CONGVIEC
insert into CONGVIEC(MADA,STT,TEN_CONG_VIEC) values(1,1,N'Thiết kế sản phẩm X'),
												(1,2,N'Thử nghiệm sản phẩm X'),
												(2,1,N'Sản xuất sản phẩm Y'),
												(2,2,N'Quảng cáo sản phẩm Y'),
												(3,1,N'Khuyễn mãi sản phẩm Z'),
												(10,1,N'Tin học hóa phòng nhân sự'),
												(10,2,N'Tin học hóa phòng kinh doanh'),
												(20,1,N'Lắp đặt cáp quang'),
												(30,1,N'Đào tạo nhân viên Marketing'),
												(30,2,N'Đào tạo chuyên viên thiết kế');