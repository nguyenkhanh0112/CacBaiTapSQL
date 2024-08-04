create database QLSV1

go 

use QLSV1 

go 

create table KHOA(
	MAKHOA varchar(10) not null primary key,
	TENKHOA nvarchar(10) null,
)

go 

create table SINHVIEN(
	MASV varchar(10),
	HOTEN nvarchar(50) null,
	DIACHI nvarchar(100) null,
	NAMSINH datetime,
	MAKHOA varchar(10) not null foreign key references KHOA(MAKHOA)
	)

go 

create table MONHOC(
	MAMON varchar(10) not null primary key,
	TENMON nvarchar(50) null
	)

	go
create table DIEMTHI(
	MAMON varchar(10) not null,
	MASV varchar(10) not null,
	DIEMTHI char(10) null,
	constraint FK_MAMON_MASV primary key(MAMON,MASV)
	)

	go
	alter table SINHVIEN
	alter column MASV varchar(10) not null 
	alter table SINHVIEN add constraint PK_MASV  primary key(MASV) 

	alter table DIEMTHI add constraint FK_MAMOM foreign key (MAMON) references MONHOC(MAMON);
	alter table DIEMTHI add constraint FK_MASV foreign key(MASV) references SINHVIEN(MASV);
	

	alter table SINHVIEN
	add KHOAHOC nvarchar(30)


	alter table DIEMTHI 
	add constraint CK1 check(DIEMTHI between 0 and 10);


	-- chèn dữ liệu
	select * from SINHVIEN

	insert into KHOA (MAKHOA,TENKHOA) values ('K001','CNTT'),
					('K002','CK'),
					('K003','DT'),
					('K004','TA');

	insert into SINHVIEN(MASV,HOTEN,DIACHI,NAMSINH,MAKHOA,KHOAHOC) values 
				('SV001',N'Nguyễn Thị Như',N'Hưng yên','1990','K001','2008-2012'),
				('SV002',N'Vũ Thị Ngọc Út',N'Hưng Yên','1900','K003','2008-2012'),
				('SV003',N'Nguyễn Thị Trang',N'Kim Động-Hưng yên','1991','K002','2008-2012'),
				('SV004',N'Nguyễn Thị Nhý',N'Hưng yên','1990','K004','2008-2012');					

	insert into MONHOC(MAMON,TENMON) values
				('MH001',N'Tiếng Anh'),
				('MH002',N'Toán Cao Cấp'),
				('MH003',N'Hệ quản trị SQL Server'),
				('MH004',N'Vật lý');

	insert into DIEMTHI(MAMON,MASV,DIEMTHI) values 
				('MH001','SV001','10'),
				('MH002','SV002','9'),
				('MH003','SV003','8'),
				('MH004','SV004','7');
--- Tìm sinh viên bị trượt môn Hệ quản trị SQL server
select * from DIEMTHI
select SINHVIEN.MASV,HOTEN, DIACHI,NAMSINH,MAKHOA,KHOAHOC  from SINHVIEN, DIEMTHI,MONHOC
where DIEMTHI.DIEMTHI>5 and DIEMTHI.MASV = SINHVIEN.MASV and DIEMTHI.MAMON = MONHOC.MAMON and MONHOC.TENMON like '%SQL Server%';


alter table DIEMTHI
alter column DIEMTHI int

-- tìm số sinh viên thuộc khoa công nghệ thoong tin 

select SINHVIEN.MAKHOA,count(SINHVIEN.MASV) as SOLUONG from SINHVIEN,KHOA
where SINHVIEN.MAKHOA = KHOA.MAKHOA and KHOA.TENKHOA = 'CNTT' GROUP BY SINHVIEN. MAKHOA


